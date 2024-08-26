mod setup {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::testing::{set_contract_address, set_caller_address};

    // Dojo imports

    use dojo::world::{IWorldDispatcherTrait, IWorldDispatcher};
    use dojo::test_utils::{spawn_test_world, deploy_contract};

    // Internal imports
    use tonatuna::{
        systems::{actions::{actions, IActions, IActionsDispatcher, IActionsDispatcherTrait}},
        models::{player::Player, fish_pond::FishPond}
        // models::{{Position, Vec2, position, Moves, Direction, moves}}
    };

    // Constants
    fn PLAYER() -> ContractAddress {
        starknet::contract_address_const::<'PLAYER'>()
    }

    const PLAYER_NAME: felt252 = 'PLAYER';

    #[derive(Drop)]
    struct Systems {
        actions: IActionsDispatcher,
    }

    #[derive(Drop)]
    struct Context {
        player_id: felt252,
        player_name: felt252,
        fish_pond_id: u32,
    }

    #[inline(always)]
    fn spawn_game() -> (IWorldDispatcher, Systems, Context) {
        // [Setup] World

        // models
        let mut models = core::array::ArrayTrait::new();
        models.append(tonatuna::models::index::player::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish_pond::TEST_CLASS_HASH);

        // deploy world with models
        let world = spawn_test_world(["tonatuna"].span(), models.span());

        // [Setup] Systems
        let actions_address = deploy_contract(actions::TEST_CLASS_HASH, array![].span());
        let systems = Systems {
            actions: IActionsDispatcher { contract_address: actions_address },
        };

        // [Setup] Context
        set_contract_address(PLAYER());
        systems.actions.signup(world, PLAYER_NAME);

        // [Setup] Game
        let game_id = systems.actions.start(world);

        let context = Context {
            player_id: PLAYER().into(), player_name: PLAYER_NAME, game_id: game_id,
        };

        // [Return]
        (world, systems, context)
    }
}
