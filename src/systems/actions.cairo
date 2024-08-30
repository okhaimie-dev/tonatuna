// Starknet imports
use starknet::ContractAddress;

// Dojo imports
use dojo::world::IWorldDispatcher;

// Internal imports
use tonatuna::models::player::Player;
use tonatuna::types::vec2::Vec2;

// define the interface
#[starknet::interface]
trait IActions<TContractState> {
    fn create_fish_pond(self: @TContractState) -> u32;
    fn new_player(self: @TContractState, name: felt252) -> Player;
    fn reset_daily_attempts(self: @TContractState);
    fn buy_baits(self: @TContractState, amount: u32);
    fn move(self: @TContractState, dest_pos: Vec2);
    fn spawn_fish(self: @TContractState, fish_pond_id: u32, time_delay: u64);
    fn spawn_multiple_fishes(self: @TContractState, fish_pond_id: u32, num_fish: u32);
    fn play(self: @TContractState, fish_pond_id: u32, name: felt252);
    fn cast_fishing(self: @TContractState, fish_pond_id: u32, commitment: felt252);
    fn reel_by_revealing(
        self: @TContractState, fish_pond_id: u32, fish_id: u32, salt: u32
    );
    fn catch_the_fish(
        self: @TContractState, fish_pond_id: u32, fish_id: u32
    );
}



// dojo decorator
#[dojo::contract]
mod actions {
    // Component imports

    // use tonatuna::components::initializable::InitializableComponent;
    use tonatuna::components::playable::PlayableComponent;

    use tonatuna::constants::{SPAWNING_DELAY, INITIAL_FISH_NUM_PER_PLAYER, BUY_BAITS_AMOUNT};


    use super::{IActions, Vec2, Player};

    // Components

    #[abi(embed_v0)]
    component!(path: PlayableComponent, storage: playable, event: PlayableEvent);
    impl PlayableInternalImpl = PlayableComponent::InternalImpl<ContractState>;

    // Storage

    #[storage]
    struct Storage {
        // #[substorage(v0)]
        // initializable: InitializableComponent::Storage,
        #[substorage(v0)]
        playable: PlayableComponent::Storage,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        // #[flat]
        // InitializableEvent: InitializableComponent::Event,
        #[flat]
        PlayableEvent: PlayableComponent::Event,
    }

    // Implementations

    // #[abi(embed_v0)]
    // impl DojoResourceProviderImpl of IDojoResourceProvider<ContractState> {
    //     fn dojo_resource(self: @ContractState) -> felt252 {
    //         'actions'
    //     }
    // }

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn create_fish_pond(self: @ContractState) -> u32 {
            self.playable.create_fish_pond(self.world())
        }

        fn new_player(self: @ContractState, name: felt252) -> Player {
            self.playable.new_player(self.world(), name)
        }

        fn reset_daily_attempts(self: @ContractState) {
            self.playable.reset_daily_attempts(self.world());
        }

        fn buy_baits(self: @ContractState, amount: u32) {
            self.playable.buy_baits(self.world(), amount);
        }

        fn move(self: @ContractState, dest_pos: Vec2) {
            self.playable.move(self.world(), dest_pos);
        }

        fn spawn_fish(self: @ContractState, fish_pond_id: u32, time_delay: u64) {
            self.playable.spawn_fish(self.world(), fish_pond_id, time_delay);
        }

        fn spawn_multiple_fishes(self: @ContractState, fish_pond_id: u32, num_fish: u32) {
            let mut i = 0;
            while i != num_fish {
                self.playable.spawn_fish(self.world(), fish_pond_id, SPAWNING_DELAY * i.into());
                i += 1;
            }
        }

        fn play(self: @ContractState, fish_pond_id: u32, name: felt252) {
            self.playable.new_player(self.world(), name);
            self.playable.buy_baits(self.world(), BUY_BAITS_AMOUNT); // TODO: implement buy_bait

            // spawn fishes INITIAL_FISH_NUM_PER_PLAYER times
            let mut i = 0;
            while i != INITIAL_FISH_NUM_PER_PLAYER {
                self.playable.spawn_fish(self.world(), fish_pond_id, SPAWNING_DELAY * i.into());
                i += 1;
            }
        }

        fn cast_fishing(self: @ContractState, fish_pond_id: u32, commitment: felt252) {
            self.playable.cast_fishing(self.world(), fish_pond_id, commitment);
        }

        fn reel_by_revealing(
            self: @ContractState, fish_pond_id: u32, fish_id: u32, salt: u32
        ) {
            self.playable.reel_by_revealing(self.world(), fish_pond_id, fish_id, salt);
        }

        fn catch_the_fish(
            self: @ContractState, fish_pond_id: u32, fish_id: u32
        ) {
            self.playable.catch_the_fish(self.world(), fish_pond_id, fish_id);
        }
    }
}
