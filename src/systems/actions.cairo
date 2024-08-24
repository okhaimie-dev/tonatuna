// define the interface
#[starknet::interface]
trait IActions<TContractState> {//fn go_fishing(self: @TContractState, name: felt252);
//fn cast_line(self: @TContractState, distance: u16, direction: u8);
//fn change_bait(self: @TContractState, bait_type: u8);
//fn reel_in(self: @TContractState);
//fn attempt_capture(self: @TContractState);
//fn check_inventory(self: @TContractState) -> Array<u8>;
//fn sell_fish(self: @TContractState, fish_type: u8, quantity: u8);
//fn move_location(self: @TContractState, new_location: u8);
}

// dojo decorator
#[dojo::contract]
mod actions {
    // Component imports

    use tonatuna::components::playable::PlayableComponent;

    use super::{IActions};

    // Components

    component!(path: PlayableComponent, storage: playable, event: PlayableEvent);
    impl PlayableInternalImpl = PlayableComponent::InternalImpl<ContractState>;

    // Storage

    #[storage]
    struct Storage {
        #[substorage(v0)]
        playable: PlayableComponent::Storage,
    }

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        PlayableEvent: PlayableComponent::Event,
    }

    // Implementations

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {}
}
