#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;

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
    use tonatuna::types::bait::Bait;
    use tonatuna::types::tuna::Tuna;
    use tonatuna::types::fishing_rod::FishingRod;

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
        fn create_fish_pond(self: @ComponentState<TContractState>, world: IWorldDispatcher) -> u32{
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Effect] Create game
            let fish_pond_id: u32 = world.uuid() + 1;
            let fish_pond = FishPondTrait::new(fish_pond_id);
            store.set_fish_pond(fish_pond);

            fish_pond_id
        }

        fn new_player(self: @ComponentState<TContractState>, world: IWorldDispatcher, id: felt252, name: felt252) -> Player {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            // let caller = get_caller_address();
            let mut player = store.get_player(id);
            player.assert_not_exists();

            // [Effect] Create player
            let player = PlayerTrait::new(id, name);
            store.set_player(player);

            player
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

        fn spawn_fish(self: @ComponentState<TContractState>, world: IWorldDispatcher, fish_pond_id: u32, fish_id: u32) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Effect] Get fish pond
            let fish_pond: FishPond = store.get_fish_pond(fish_pond_id);
            fish_pond.assert_exists();

            // [Effect] Spawn fish
            let new_fish: Fish = FishTrait::new(fish_pond_id, fish_id);

            // [Effect] Update fish pond
            // store.set_fish_pond(fish_pond);
            store.set_fish(new_fish);
        }



        fn fish(self: @ComponentState<TContractState>, world: IWorldDispatcher, fish_pond_id: u32, fishing_rod: FishingRod) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Check] Player exists
            let caller = get_caller_address();
            let mut player = store.get_player(caller.into());
            player.assert_exists();

            // [Effect] Get fish pond
            let fish_pond: FishPond = store.get_fish_pond(fish_pond_id);

            // [Effect] Fish
            // let tuna: Tuna = fish_pond.fish(fishing_rod);

            // [Effect] Update fish pond
            store.set_fish_pond(fish_pond);

            // [Effect] Update player
            store.set_player(player);
            
        }
    }
}
