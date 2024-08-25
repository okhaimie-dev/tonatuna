// Core imports

use core::debug::PrintTrait;

// Internal imports
use tonatuna::constants::{MAX_DAILY_FISHING_ATTEMPTS};
use tonatuna::models::index::Player;
use tonatuna::models::index::FishPond;

mod errors {
    const PLAYER_NOT_EXIST: felt252 = 'Player: does not exist';
    const PLAYER_ALREADY_EXIST: felt252 = 'Player: already exist';
    const PLAYER_INVALID_NAME: felt252 = 'Player: invalid name';
    const PLAYER_NOT_ENOUGH_BAIT: felt252 = 'Player: not enough bait';
}

#[generate_trait]
impl PlayerImpl of PlayerTrait {
    #[inline]
    fn new(id: felt252, name: felt252) -> Player {
        // [Check] Name is valid
        assert(name != 0, errors::PLAYER_INVALID_NAME);
        // [Return] Player
        Player { id, name, bait_balance: 0, fish_caught: 0, daily_attempts: 0, }
    }

    #[inline]
    fn buy_bait(ref self: Player, quantity: u8) { // use ERC20 to buy bait
    }

    #[inline]
    fn fish(ref self: Player, pond: FishPond) { // [Check] Player has enough bait
    }
}

#[generate_trait]
impl PlayerAssert of AssertTrait {
    #[inline]
    fn assert_is_affordable(self: Player, qty: u16) {}

    #[inline]
    fn assert_enough_bait(self: Player, qty: u16) {}
}
