// Internal imports
use tonatuna::constants::{DAILY_CATCH_LIMIT};
use tonatuna::models::index::FishPond;

mod errors {
    const POND_CATCH_LIMIT_REACHED: felt252 = 'Pond: daily catch limit reached';
    const POND_NOT_ENOUGH_FISH: felt252 = 'Pond: not enough fish to catch';
    const POND_ACTION_TOO_SOON: felt252 = 'Pond: action too soon';
    const POND_DOESNT_EXIST: felt252 = 'Pond: does not exist';
}

#[generate_trait]
impl FishPondImpl of FishPondTrait {
    #[inline]
    fn new(id: u32) -> FishPond {
        FishPond {
            id,
            fish_population: 0,
            daily_catch_limit: DAILY_CATCH_LIMIT,
            rare_fish_chance: 5,
            daily_catches: 0,
        }
    }

    fn reset_daily_catches(ref self: FishPond) {
        self.daily_catches = 0;
    }
}

#[generate_trait]
impl FishPondAssert of AssertTrait {
    fn assert_catch_limit_not_reached(self: FishPond, amount: u32) {
        assert(
            self.daily_catches + amount <= self.daily_catch_limit, errors::POND_CATCH_LIMIT_REACHED
        );
    }

    fn assert_enough_fish(self: FishPond, amount: u32) {
        assert(self.fish_population >= amount, errors::POND_NOT_ENOUGH_FISH);
    }

    fn assert_exists(self: FishPond) {
        assert(self.id != 0, errors::POND_DOESNT_EXIST);
    }
}
