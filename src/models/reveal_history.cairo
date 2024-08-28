// Core imports
use core::debug::PrintTrait;
use starknet::info::get_block_timestamp;


// Internal imports
use tonatuna::models::index::RevealHistory;
use tonatuna::types::vec2::Vec2;

// use tonatuna::helpers::dice::{Dice, DiceTrait};

use tonatuna::constants::MAX_SIZE;

mod errors {
    const FISH_POND_ID_INVALID: felt252 = 'fish_pond_id is invalid';
    const FISH_ID_INVALID: felt252 = 'fish_id is invalid';
}

#[generate_trait]
impl RevealHistoryImpl of RevealHistoryTrait {
    #[inline]
    fn new(fish_pond_id: u32, fish_id: u32) -> RevealHistory {
        RevealHistory {
            fish_pond_id,
            fish_id,
            timestamp: get_block_timestamp(),
            count: 1
        }
    }
}

#[generate_trait]
impl RevealHistoryAssert of AssertTrait {
    #[inline]
    fn assert_valid_reveal_history(self: RevealHistory) {
        // [Check] RevealHistory is valid
        assert(self.fish_pond_id != 0, errors::FISH_POND_ID_INVALID);
        assert(self.fish_id != 0, errors::FISH_ID_INVALID);
    }
}
