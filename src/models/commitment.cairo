// Core imports
use core::debug::PrintTrait;

// Internal imports
use tonatuna::models::index::Commitment;
use tonatuna::types::vec2::Vec2;

use tonatuna::helpers::dice::{Dice, DiceTrait};

use tonatuna::constants::MAX_SIZE;

mod errors {
    const COMMITMENT_PLAYER_ID_INVALID: felt252 = 'player_id is invalid';
    const COMMITMENT_FISH_POND_ID_INVALID: felt252 = 'fish_pond_id is invalid';
}

#[generate_trait]
impl CommitmentImpl of CommitmentTrait {
    #[inline]
    fn new(player_id: felt252, fish_pond_id: u32) -> Commitment {
        Commitment {
            player_id,
            fish_pond_id,
            value: 0,
            nonce: 0,
            timestamp: 0,
        }
    }
}

#[generate_trait]
impl CommitmentAssert of AssertTrait {
    #[inline]
    fn assert_valid_commitment(self: Commitment) {
        // [Check] Commitment is valid
        assert(self.player_id != 0, errors::COMMITMENT_PLAYER_ID_INVALID);
        assert(self.fish_pond_id != 0, errors::COMMITMENT_FISH_POND_ID_INVALID);
    }
}
