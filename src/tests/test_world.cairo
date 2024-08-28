#[cfg(test)]
mod tests {
    // Core imports
    use core::debug::PrintTrait;
    use core::poseidon::PoseidonTrait;
    use core::hash::HashStateTrait;

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
        models::{player::Player, fish_pond::FishPond, fish::Fish, commitment::Commitment, reveal_history::RevealHistory},
        types::vec2::Vec2,
        // models::{{Position, Vec2, position, Moves, Direction, moves}}
        // helpers::random::random_num
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
        let mut player = actions_system.new_player(id: caller.into(), name: 'Bob');

        actions_system.move(Vec2{ x: 1, y: 1 });

        player = store.get_player(caller.into());

        assert(player.name == 'Bob', 'name is wrong');
        assert(player.position.x == 1, 'position x is wrong');
        assert(player.position.y == 1, 'position y is wrong');
    }

    #[test]
    fn test_spawn_fish() {
        // // caller
        // let caller = starknet::contract_address_const::<0x0>();

        // models
        let mut models = core::array::ArrayTrait::new();
        models.append(tonatuna::models::index::player::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish_pond::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish::TEST_CLASS_HASH);

        // deploy world with models
        let world = spawn_test_world(["tonatuna"].span(), models.span());

        let store = StoreTrait::new(world);

        // deploy systems contract
        let contract_address = world
            .deploy_contract('salt', actions::TEST_CLASS_HASH.try_into().unwrap());
        let actions_system = IActionsDispatcher { contract_address };

        world.grant_writer(dojo::utils::bytearray_hash(@"tonatuna"), contract_address);
        // // register the player
        // let mut player = actions_system.new_player(id: caller.into(), name: 'Bob');

        // create the fish pond
        let fish_pond_id = actions_system.create_fish_pond();

        // spawn the fish
        actions_system.spawn_fish(fish_pond_id, 1);


        let fish = store.get_fish(fish_pond_id, 1);

        assert(fish.fish_pond_id == fish_pond_id, 'fish id is wrong');
        assert(fish.position.x != 0, 'position x is wrong');
        assert(fish.position.y != 0, 'position y is wrong');

        println!("fish position x: {}", fish.position.x);
        println!("fish position y: {}", fish.position.y);

        // assert(player.name == 'Bob', 'name is wrong');
        // assert(player.position.x == 1, 'position x is wrong');
        // assert(player.position.y == 1, 'position y is wrong');
    }

    #[test]
    fn test_spawn_multiple_fishes() {
        // // caller
        // let caller = starknet::contract_address_const::<0x0>();

        // models
        let mut models = core::array::ArrayTrait::new();
        models.append(tonatuna::models::index::player::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish_pond::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish::TEST_CLASS_HASH);

        // deploy world with models
        let world = spawn_test_world(["tonatuna"].span(), models.span());

        let store = StoreTrait::new(world);

        // deploy systems contract
        let contract_address = world
            .deploy_contract('salt', actions::TEST_CLASS_HASH.try_into().unwrap());
        let actions_system = IActionsDispatcher { contract_address };

        world.grant_writer(dojo::utils::bytearray_hash(@"tonatuna"), contract_address);
        // // register the player
        // let mut player = actions_system.new_player(id: caller.into(), name: 'Bob');

        // create the fish pond
        let fish_pond_id = actions_system.create_fish_pond();

        let NUM_FISHES = 5;

        // spawn the fish
        actions_system.spawn_multiple_fishes(fish_pond_id, NUM_FISHES);

        let mut i = 1;

        while i != NUM_FISHES {
            let fish = store.get_fish(fish_pond_id, i);

            assert(fish.fish_pond_id == fish_pond_id, 'fish id is wrong');
            println!("fish position x: {}", fish.position.x);
            println!("fish position y: {}", fish.position.y);

            i += 1;
        }

        // assert(player.name == 'Bob', 'name is wrong');
        // assert(player.position.x == 1, 'position x is wrong');
        // assert(player.position.y == 1, 'position y is wrong');
    }

    #[test]
    fn test_cast_fishing() {
        // caller
        let caller = starknet::contract_address_const::<0x0>();

        // models
        let mut models = core::array::ArrayTrait::new();
        models.append(tonatuna::models::index::player::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish_pond::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::commitment::TEST_CLASS_HASH);

        // deploy world with models
        let world = spawn_test_world(["tonatuna"].span(), models.span());

        let store = StoreTrait::new(world);

        // deploy systems contract
        let contract_address = world
            .deploy_contract('salt', actions::TEST_CLASS_HASH.try_into().unwrap());
        let actions_system = IActionsDispatcher { contract_address };

        world.grant_writer(dojo::utils::bytearray_hash(@"tonatuna"), contract_address);

        // register the player
        let mut player = actions_system.new_player(id: caller.into(), name: 'Bob');

        player.bait_balance = 5; // implement "buy bait" later
        store.set_player(player);

        // create the fish pond
        let fish_pond_id = actions_system.create_fish_pond();
        let fish_id = 1;
        let salt = 123; // secret number.

        // spawn the fish
        actions_system.spawn_fish(fish_pond_id, 1);

        // hash the commitment
        let hash_state = PoseidonTrait::new();
        let hash_state = hash_state.update(fish_id);
        let hash_state = hash_state.update(salt);

        let commitment_value = hash_state.finalize().into(); // fish_id, salt

        // cast the fishing rod
        actions_system.cast_fishing(fish_pond_id, commitment_value);

        let commitment = store.get_commitment(caller.into(), fish_pond_id);

        // println!("commitment value: {}", commitment.value); // 1351846939947373597151552475990911731122143735091351208236876836383481829808

        assert(commitment.value == 1351846939947373597151552475990911731122143735091351208236876836383481829808, 'commitment value is wrong');

        // assert(player.name == 'Bob', 'name is wrong');
        // assert(player.position.x == 1, 'position x is wrong');
        // assert(player.position.y == 1, 'position y is wrong');
    }

    #[test]
    #[should_panic] // ERROR should be occur: 'you have to wait'
    fn test_reeling() {
        // caller
        let caller = starknet::contract_address_const::<0x0>();

        // models
        let mut models = core::array::ArrayTrait::new();
        models.append(tonatuna::models::index::player::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish_pond::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::fish::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::commitment::TEST_CLASS_HASH);
        models.append(tonatuna::models::index::reveal_history::TEST_CLASS_HASH);

        // deploy world with models
        let world = spawn_test_world(["tonatuna"].span(), models.span());

        let store = StoreTrait::new(world);

        // deploy systems contract
        let contract_address = world
            .deploy_contract('salt', actions::TEST_CLASS_HASH.try_into().unwrap());
        let actions_system = IActionsDispatcher { contract_address };

        world.grant_writer(dojo::utils::bytearray_hash(@"tonatuna"), contract_address);

        // register the player
        let mut player = actions_system.new_player(id: caller.into(), name: 'Bob');

        player.bait_balance = 5; // implement "buy bait" later
        store.set_player(player);

        // create the fish pond
        let fish_pond_id = actions_system.create_fish_pond();
        let fish_id: u32 = 1;
        let salt: u32 = 123; // secret number.

        // spawn the fish
        actions_system.spawn_fish(fish_pond_id, 1);

        // hash the commitment
        let hash_state = PoseidonTrait::new();
        let hash_state = hash_state.update(fish_id.into());
        let hash_state = hash_state.update(salt.into());

        let commitment_value = hash_state.finalize().into(); // fish_id, salt

        // cast the fishing rod
        actions_system.cast_fishing(fish_pond_id, commitment_value);

        // let commitment = store.get_commitment(caller.into(), fish_pond_id);

        // println!("commitment value: {}", commitment.value); // 1351846939947373597151552475990911731122143735091351208236876836383481829808

        // assert(commitment.value == 1351846939947373597151552475990911731122143735091351208236876836383481829808, 'commitment value is wrong');


        // reel the fish
        // ERROR should be occur: 'you have to wait'
        actions_system.reel_by_revealing(caller.into(), fish_pond_id, fish_id, salt);
   }
}
