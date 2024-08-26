// Core imports
use core::debug::PrintTrait;

// Internal imports
use tonatuna::models::index::Fish;
use tonatuna::types::vec2::Vec2;

mod errors {
    const FISH_POND_ID_INVALID: felt252 = 'Fish: pond_id is invalid';
}

#[generate_trait]
impl FishImpl of FishTrait {
    #[inline]
    fn new(fish_pond_id: u32, fish_id: u32) -> Fish {
        assert(fish_pond_id != 0, errors::FISH_POND_ID_INVALID);
        Fish {
            fish_pond_id,
            fish_id,
            position: Vec2 { x: 0, y: 0 },
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
