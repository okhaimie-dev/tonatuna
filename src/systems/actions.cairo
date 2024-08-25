// define the interface
#[starknet::interface]
trait IActions<TContractState> {
    fn create_fish_pond(self: @TContractState);
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
    impl ActionsImpl of IActions<ContractState> {
        fn create_fish_pond(self: @ContractState) {
            self.playable.create_fish_pond(self.world())
        }
    }
}
