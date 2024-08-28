//! Store struct and component management methods.

// Dojo imports
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Model imports
use tonatuna::models::player::Player;
use tonatuna::models::fish_pond::FishPond;
use tonatuna::models::fish::Fish;
use tonatuna::models::commitment::Commitment;
use tonatuna::models::reveal_history::RevealHistory;

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
    fn get_fish_pond(self: Store, fish_pond_id: u32) -> FishPond {
        get!(self.world, fish_pond_id, (FishPond))
    }

    #[inline]
    fn get_fish(self: Store, fish_pond_id: u32, fish_id: u32) -> Fish {
        get!(self.world, (fish_pond_id, fish_id), (Fish))
    }

    #[inline]
    fn get_commitment(self: Store, player_id: felt252, fish_pond_id: u32) -> Commitment {
        get!(self.world, (player_id, fish_pond_id), (Commitment))
    }

    #[inline]
    fn get_reveal_history(self: Store, fish_pond_id: u32, fish_id: u32) -> RevealHistory {
        get!(self.world, (fish_pond_id, fish_id), (RevealHistory))
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

    #[inline]
    fn set_fish(self: Store, fish: Fish) {
        set!(self.world, (fish))
    }

    #[inline]
    fn set_commitment(self: Store, commitment: Commitment) {
        set!(self.world, (commitment))
    }

    #[inline]
    fn set_reveal_history(self: Store, reveal_history: RevealHistory) {
        set!(self.world, (reveal_history))
    }
}
