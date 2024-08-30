// Core imports
use core::debug::PrintTrait;
use starknet::info::{get_caller_address, get_block_timestamp};


// Internal imports
use tonatuna::models::index::Fish;
use tonatuna::types::vec2::Vec2;
use tonatuna::types::fish_status::FishStatus;

use tonatuna::helpers::dice::{Dice, DiceTrait};

use tonatuna::constants::MAX_SIZE;


mod errors {
    const FISH_POND_ID_INVALID: felt252 = 'Fish: pond_id is invalid';
}

#[generate_trait]
impl FishImpl of FishTrait {
    #[inline]
    fn new(fish_pond_id: u32, fish_id: u32, seed: felt252, time_delay: u64) -> Fish {
        assert(fish_pond_id != 0, errors::FISH_POND_ID_INVALID);
        // [Setup] Dice
        // fish_id * 2 + 1: to avoid having the same nonce as the next fish
        let mut dice: Dice = DiceTrait::new_with_nonce(MAX_SIZE, seed, (fish_id * 2).into());

        let mut status = FishStatus::Spawning.into();

        if time_delay == 0 {
            status = FishStatus::Swimming.into();
        }

        Fish {
            fish_pond_id,
            fish_id,
            position: Vec2 { x: dice.roll().into(), y: dice.roll().into() },
            weight: 1,
            status: status,
            spawn_time: get_block_timestamp() + time_delay,
        }
    }
}

#[generate_trait]
impl FishAssert of AssertTrait {
    #[inline]
    fn assert_valid_fish_pond_id(self: Fish) {
        // [Check] Pond ID is valid
        assert(self.fish_pond_id != 0, errors::FISH_POND_ID_INVALID);
    }

    #[inline]
    fn is_swimming(self: Fish) -> bool {
        if self.status == FishStatus::Swimming.into() {
            return true;
        } else {
            return false;
        }
    }

    #[inline]
    fn is_caught(self: Fish) -> bool {
        if self.status == FishStatus::Caught.into() {
            return true;
        } else {
            return false;
        }
    }
}
