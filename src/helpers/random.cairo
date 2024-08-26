// TODO: implement Random number to be used in generating fishes.

// Core imports

use core::poseidon::{PoseidonTrait, HashState};
use core::hash::HashStateTrait;

// Internal imports

// use rpg::constants::{SEED_WEEK_SECONDS, SEED_OFFSET_SECONDS};

#[generate_trait]
impl Seeder of SeederTrait {
    #[inline]
    fn reseed(lhs: felt252, rhs: felt252) -> felt252 {
        let state: HashState = PoseidonTrait::new();
        let state = state.update(lhs);
        let state = state.update(rhs);
        state.finalize()
    }

    #[inline]
    fn compute_id(time: u64) -> u64 {
        let SEED_WEEK_SECONDS: u64 = 604800;
        let SEED_OFFSET_SECONDS: u64 = 1609459200;
        (time + SEED_OFFSET_SECONDS) / SEED_WEEK_SECONDS
    }
}