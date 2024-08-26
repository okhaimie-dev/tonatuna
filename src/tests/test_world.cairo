#[cfg(test)]
mod tests {
    // Core imports
    use core::debug::PrintTrait;

    // starknet imports
    use starknet::ContractAddress;
    use starknet::testing::{set_contract_address, set_caller_address};

    // import world dispatcher
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    // import test utils
    use dojo::utils::test::{spawn_test_world, deploy_contract};

    // import tonatuna
    use tonatuna::{
        systems::{actions::{actions, IActionsDispatcher, IActionsDispatcherTrait}},
        models::{player::Player, fish_pond::FishPond}
        // models::{{Position, Vec2, position, Moves, Direction, moves}}
    };

    use tonatuna::store::{Store, StoreTrait};

    #[test]
    fn test_move() {
        // caller
        let caller = starknet::contract_address_const::<0x0>();

        // models
        let mut models = core::array::ArrayTrait::new();
        models.append(tonatuna::models::index::player::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish_pond::TEST_CLASS_HASH);

        // deploy world with models
        let world = spawn_test_world(["tonatuna"].span(), models.span());

        let store = StoreTrait::new(world);

        // deploy systems contract
        let contract_address = world
            .deploy_contract('salt', actions::TEST_CLASS_HASH.try_into().unwrap());
        let actions_system = IActionsDispatcher { contract_address };

        world.grant_writer(dojo::utils::bytearray_hash(@"tonatuna"), contract_address);

        // register the player
        let mut player = Player::new(1, "Bob"); // id(felt252), name(252)

        actions_system.move(Vec2{ x: 1, y: 1 });

        player = store.get_player(caller.into());

        assert(player.position.x == 1, 'position x is wrong');
        assert(player.position.y == 1, 'position y is wrong');

    }
}
