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
    use tonatuna::models::fish_pond::{FishPond, FishPondTrait, FishPondAssert};
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
        fn create_fish_pond(self: @ComponentState<TContractState>, world: IWorldDispatcher) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Effect] Create game
            let fish_pond_id: u32 = world.uuid() + 1;
            let fish_pond = FishPondTrait::new(fish_pond_id);
            store.set_fish_pond(fish_pond);
        }
    }
}
