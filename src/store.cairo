//! Store struct and component management methods.

// Dojo imports
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Model imports
use tonatuna::models::player::Player;
use tonatuna::models::fish_pond::FishPond;

// Structs
#[derive(Copy, Drop)]
struct Store {
    world: IWorldDispatcher,
}

// Implementations
#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline]
    fn new(world: IWorldDispatcher) -> Store {
        Store { world: world }
    }

    #[inline]
    fn get_state(self: Store, player_id: felt252) -> (Player, FishPond) {
        get!(self.world, player_id, (Player, FishPond))
    }

    #[inline]
    fn get_player(self: Store, player_id: felt252) -> Player {
        get!(self.world, player_id, (Player))
    }

    #[inline]
    fn get_fish_pond(self: Store, player_id: felt252) -> FishPond {
        get!(self.world, player_id, (FishPond))
    }

    #[inline]
    fn set_state(self: Store, player: Player, fish_pond: FishPond) {
        set!(self.world, (player, fish_pond))
    }

    #[inline]
    fn set_player(self: Store, player: Player) {
        set!(self.world, (player))
    }

    #[inline]
    fn set_fish_pond(self: Store, fish_pond: FishPond) {
        set!(self.world, (fish_pond))
    }
}
