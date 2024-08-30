#[starknet::component]
mod PlayableComponent {
    // Core imports
    use core::debug::PrintTrait;
    use core::poseidon::PoseidonTrait;
    use core::hash::HashStateTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::info::{get_caller_address, get_block_timestamp};

    // Dojo imports

    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;

    // Internal imports
    use tonatuna::store::{Store, StoreTrait};
    use tonatuna::types::vec2::Vec2;
    use tonatuna::models::fish_pond::{FishPond, FishPondTrait, FishPondAssert};
    use tonatuna::models::player::{Player, PlayerTrait, PlayerAssert};
    use tonatuna::models::fish::{Fish, FishTrait, FishAssert};
    use tonatuna::models::commitment::{Commitment, CommitmentTrait, CommitmentAssert};
    use tonatuna::models::reveal_history::{RevealHistory, RevealHistoryTrait, RevealHistoryAssert};
    use tonatuna::types::bait::Bait;
    use tonatuna::types::tuna::Tuna;
    use tonatuna::types::fishing_rod::FishingRod;
    use tonatuna::types::fish_status::FishStatus;
    use tonatuna::types::commit_status::CommitStatus;
    use tonatuna::constants::{REEL_DURATION, CATCH_DURATION, BAIT_PRICE, TOKEN_ADDRESS, GAME_CONTRACT_ADDRESS};
    use tonatuna::interfaces::ierc20::{ierc20, IERC20Dispatcher, IERC20DispatcherTrait};

    // Errors

    mod errors {}

    // Storage

    #[storage]
    struct Storage {}

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn create_fish_pond(self: @ComponentState<TContractState>, world: IWorldDispatcher) -> u32 {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Effect] Create game
            let fish_pond_id: u32 = world.uuid() + 1;
            let fish_pond = FishPondTrait::new(fish_pond_id);
            store.set_fish_pond(fish_pond);

            fish_pond_id
        }

        fn new_player(
            self: @ComponentState<TContractState>, world: IWorldDispatcher, name: felt252
        ) -> Player {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_not_exists();

            // [Effect] Create player
            let player = PlayerTrait::new(caller.into(), name);
            store.set_player(player);

            player
        }

        fn buy_baits(
            self: @ComponentState<TContractState>, world: IWorldDispatcher, amount: u32
        ) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_exists();

            // FIXME: Have to pay ETH/STRK for buying baits

            // have to change the contract address
            let token = ierc20(TOKEN_ADDRESS());
            let total = token.total_supply();
            println!("total supply: {}", total);


            // [Check] assert that the caller has enough tokens
            assert(token.balance_of(caller.into()) >= amount.into() * BAIT_PRICE.into(), 'not enough tokens');

            // [Check] if the caller allowed enogh tokens to the contract
            assert(token.allowance(caller.into(), get_contract_address().into()) >= amount.into() * BAIT_PRICE.into(), 'not enough allowance');

            // send tokens from caller to contract
            token.transfer_from(caller.into(), GAME_CONTRACT_ADDRESS(), amount.into() * BAIT_PRICE.into());


            // [Effect] Buy baits
            player.bait_balance += amount;

            // [Effect] Update player
            store.set_player(player);
        }

        fn reset_daily_attempts(
            self: @ComponentState<TContractState>, world: IWorldDispatcher
        ) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_exists();

            // [Effect] Reset daily attempts
            player.daily_attempts = 0;

            // [Effect] Update player
            store.set_player(player);
        }

        fn move(self: @ComponentState<TContractState>, world: IWorldDispatcher, dest_pos: Vec2) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_exists();

            // [Effect] Move player
            player.position = dest_pos;

            // [Effect] Update player
            store.set_player(player);
        }

        fn spawn_fish(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            fish_pond_id: u32,
            time_delay: u64
        ) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Effect] Get fish pond
            let mut fish_pond: FishPond = store.get_fish_pond(fish_pond_id);
            fish_pond.assert_exists();

            let old_fish = store.get_fish(fish_pond_id, fish_id);
            assert(old_fish.status == FishStatus::None.into(), 'fish_id is already used');
            // [Effect] Spawn fish
            let new_fish: Fish = FishTrait::new(
                fish_pond_id, fish_pond.max_fish_id, get_block_timestamp().into(), time_delay
            );

            fish_pond.max_fish_id += 1;
            fish_pond.fish_population += 1;

            // [Effect] Update fish pond
            store.set_fish_pond(fish_pond);

            // [Effect] Update fish pond
            // store.set_fish_pond(fish_pond);
            store.set_fish(new_fish);
        }


        fn cast_fishing(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            fish_pond_id: u32,
            commitment: felt252
        ) { // deleted fish_rod: FishingRod for now.
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_exists();
            // [Check] Player has enough bait
            player.assert_is_affordable(1);
            // [Check] Player has enough bait
            player.assert_enough_bait(1);
            // [Check] Player has not reached the daily limit
            player.assert_daily_attempts();

            // [Check] Fish has not been caught

            // [Update] Player's bait balance
            player.bait_balance -= 1;
            // [Update] Player's daily attempts
            player.daily_attempts += 1;

            let mut commit: Commitment = store.get_commitment(caller.into(), fish_pond_id);

            commit.status = CommitStatus::Committed.into();
            commit.value = commitment;
            commit.timestamp = get_block_timestamp();

            // [Effect] Set player info
            store.set_player(player);
            // [Effect] Set commitment
            store.set_commitment(commit);

            // [Effect] Update player
            store.set_player(player);
        }

        // Reveal the commitment to catch the fish
        fn reel_by_revealing(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            fish_pond_id: u32,
            fish_id: u32,
            salt: u32
        ) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_exists();

            // [Check] Fish has not been caught
            let mut fish = store.get_fish(fish_pond_id, fish_id);
            if ((fish.status == FishStatus::Spawning.into()) & (fish.spawn_time >= get_block_timestamp())) {
                // [Effect] fish is spawned and swimming now.
                fish.status = FishStatus::Swimming.into();
                store.set_fish(fish);
            }
            assert(fish.is_swimming(), 'fish is not swimming');

            // [Check] Commitment Hash is correct
            let hash_state = PoseidonTrait::new();
            let hash_state = hash_state.update(fish_id.into());
            let hash_state = hash_state.update(salt.into());
            let commitment_value = hash_state.finalize().into();

            let mut commitment: Commitment = store.get_commitment(caller.into(), fish_pond_id);
            assert(commitment_value == commitment.value, 'hash value is wrong');

            assert(commitment.timestamp > fish.spawn_time, 'your fishing was too early');

            // [Check] the time is over REEL_DURATION
            assert(
                get_block_timestamp() - commitment.timestamp > REEL_DURATION, 'you have to wait'
            );

            // [Check] reveal history
            let mut reveal_history = store.get_reveal_history(fish_pond_id, fish_id);

            // [Check] commitment.timestamp is over reveal_history.commit_timestamp
            assert(
                commitment.timestamp >= reveal_history.commit_timestamp, 'your commit was failed'
            );

            // [Check] commitment.status is Committed
            assert(commitment.status == CommitStatus::Committed.into(), 'the commit is used');

            if (reveal_history.count != 0) {
                // [Check] it's revevant to the previous commitment.
                if (commitment.timestamp < reveal_history.reveal_timestamp) {
                    // fails to reel the fish. because someone's commitment is already revealed.
                    // [Effect] fish is getting bigger.
                    fish.weight += 1;
                    store.set_fish(fish);

                    // [Effect] reset reveal_history
                    reveal_history.commit_timestamp = get_block_timestamp();
                    reveal_history.reveal_timestamp = get_block_timestamp();
                    reveal_history.count = 0;
                }
                // else if (commitment.timestamp > reveal_history.commit_timestamp) {
            //     // can reel the fish later???
            // }
            } else {
                reveal_history.commit_timestamp = commitment.timestamp;
                reveal_history.reveal_timestamp = get_block_timestamp();
                reveal_history.count = 1;
            }

            commitment.status = CommitStatus::Revealed.into();
            store.set_commitment(commitment);

            // [Effect] Update reveal_history
            store.set_reveal_history(reveal_history);
        }

        // if the player reels the fish correctly, the fish is caught.
        fn catch_the_fish(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            fish_pond_id: u32,
            fish_id: u32,
        ) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_exists();

            // [Check] Fish has not been caught
            let mut fish = store.get_fish(fish_pond_id, fish_id);
            assert(fish.is_swimming(), 'fish is not swimming');

            // [Check] reveal_history.count == 1 and player has the correct commitment.
            let mut reveal_history = store.get_reveal_history(fish_pond_id, fish_id);
            assert(reveal_history.count == 1, 'reeling failed');

            // // [Check] Commitment Hash is correct : FIXME: Do we need this?????
            // let hash_state = PoseidonTrait::new();
            // let hash_state = hash_state.update(fish_id.into());
            // let hash_state = hash_state.update(salt.into());
            // let commitment_value = hash_state.finalize().into();

            let mut commitment: Commitment = store.get_commitment(caller.into(), fish_pond_id);
            // assert(commitment_value == commitment.value, 'hash value is wrong');

            // [Check] commitment.status is Revealed
            assert(commitment.status == CommitStatus::Revealed.into(), 'commit is not revealed');

            // [Check] reveal_history.timestamp is over CATCH_DURATION
            assert(
                get_block_timestamp() - reveal_history.reveal_timestamp > CATCH_DURATION,
                'you have to wait'
            );

            // [Check] reveal_history.commit_timestamp == commitment.timestamp
            assert(reveal_history.commit_timestamp == commitment.timestamp, 'commit is not yours');

            // [Effect] Set commitment status
            commitment.status = CommitStatus::Used.into();
            store.set_commitment(commitment);

            // [Effect] Set fish status
            fish.status = FishStatus::Caught.into();
            store.set_fish(fish);

            // [Effect] Update Fish Pond
            let mut fish_pond = store.get_fish_pond(fish_pond_id);
            fish_pond.fish_population -= 1;
            store.set_fish_pond(fish_pond);

            // [Effect] Update player
            player.fish_caught += 1;
            store.set_player(player);
        }
    }
}
