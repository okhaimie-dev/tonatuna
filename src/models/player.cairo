// Core imports

use core::debug::PrintTrait;

// starknet imports
use starknet::info::{get_caller_address, get_block_timestamp};

// Internal imports
use tonatuna::constants::{MAX_DAILY_FISHING_ATTEMPTS};
use tonatuna::models::index::Player;
use tonatuna::models::index::FishPond;
use tonatuna::models::index::Commitment;
use tonatuna::types::vec2::Vec2;

mod errors {
    const PLAYER_NOT_EXIST: felt252 = 'Player: does not exist';
    const PLAYER_ALREADY_EXIST: felt252 = 'Player: already exist';
    const PLAYER_INVALID_NAME: felt252 = 'Player: invalid name';
    const PLAYER_NOT_ENOUGH_BAIT: felt252 = 'Player: not enough bait';
    const PLAYER_OVER_DAILY_LIMIT: felt252 = 'Player: over daily limit';
}

#[generate_trait]
impl PlayerImpl of PlayerTrait {
    #[inline]
    fn new(id: felt252, name: felt252) -> Player {
        // [Check] Name is valid
        assert(name != 0, errors::PLAYER_INVALID_NAME);
        // [Return] Player
        Player { id, name, bait_balance: 0, fish_caught: 0, daily_attempts: 0, position: Vec2 { x: 0, y: 0 }}
    }

    #[inline]
    fn buy_bait(ref self: Player, quantity: u8) { // use ERC20 to buy bait
        // [Check] Player has enough bait
    }
}

#[generate_trait]
impl PlayerAssert of AssertTrait {
    #[inline]
    fn assert_is_affordable(self: Player, qty: u32) {
        // [Check] Player has enough balance
    }

    #[inline]
    fn assert_enough_bait(self: Player, qty: u32) {
        // [Check] Player has enough bait
        assert(self.bait_balance >= qty, errors::PLAYER_NOT_ENOUGH_BAIT);
    }

    #[inline]
    fn assert_daily_attempts(self: Player) {
        // [Check] Player has not reached the daily limit
        assert(self.daily_attempts < MAX_DAILY_FISHING_ATTEMPTS, errors::PLAYER_OVER_DAILY_LIMIT);
    }

    #[inline]
    fn assert_exists(self: Player) {
        assert(self.is_non_zero(), errors::PLAYER_NOT_EXIST);
    }

    #[inline]
    fn assert_not_exists(self: Player) {
        assert(self.is_zero(), errors::PLAYER_ALREADY_EXIST);
    }
}

impl ZeroablePlayerImpl of core::Zeroable<Player> {
    #[inline]
    fn zero() -> Player {
        Player { id: 0, name: 0, bait_balance: 0, fish_caught: 0, daily_attempts: 0, position: Vec2 { x: 0, y: 0 } }
    }

    #[inline]
    fn is_zero(self: Player) -> bool {
        0 == self.name
    }

    #[inline]
    fn is_non_zero(self: Player) -> bool {
        !self.is_zero()
    }
}
