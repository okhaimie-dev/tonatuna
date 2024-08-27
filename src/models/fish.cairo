// Core imports
use core::debug::PrintTrait;

// Internal imports
use tonatuna::models::index::Fish;
use tonatuna::types::vec2::Vec2;

use tonatuna::helpers::dice::{Dice, DiceTrait};

use tonatuna::constants::MAX_SIZE;

mod errors {
    const FISH_POND_ID_INVALID: felt252 = 'Fish: pond_id is invalid';
}

#[generate_trait]
impl FishImpl of FishTrait {
    #[inline]
    fn new(fish_pond_id: u32, fish_id: u32, seed: felt252) -> Fish {
        assert(fish_pond_id != 0, errors::FISH_POND_ID_INVALID);
        // [Setup] Dice
        // should we use the same seed and increment nonce for all fish?
        let mut dice: Dice = DiceTrait::new(MAX_SIZE, seed);

        Fish {
            fish_pond_id,
            fish_id,
            position: Vec2 { x: dice.roll().into(), y: dice.roll().into() },
            weight: 1,
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
}
