// Internal imports

use tonatuna::models::index::FishPond;

mod errors {
    const POND_CATCH_LIMIT_REACHED: felt252 = 'Pond: daily catch limit reached';
    const POND_NOT_ENOUGH_FISH: felt252 = 'Pond: not enough fish to catch';
    const POND_ACTION_TOO_SOON: felt252 = 'Pond: action too soon';
}

#[generate_trait]
impl FishPondImpl of FishPondTrait {
    #[inline]
    fn new(id: felt252) -> FishPond {
        FishPond {
            id,
            fish_population: 1000,
            daily_catch_limit: 100,
            depth: 50,
            rare_fish_chance: 5,
            daily_catches: 0,
        }
    }

    fn reset_daily_catches(ref self: FishPond) {
        self.daily_catches = 0;
    }

    fn catch_fish(ref self: FishPond) -> bool {
        if self.daily_catches >= self.daily_catch_limit {
            return false;
        }

        self.daily_catches += 1;
        true
    }
}

#[generate_trait]
impl FishPondAssert of AssertTrait {
    fn assert_catch_limit_not_reached(self: FishPond, amount: u16) {
        assert(
            self.daily_catches + amount <= self.daily_catch_limit, errors::POND_CATCH_LIMIT_REACHED
        );
    }

    fn assert_enough_fish(self: FishPond, amount: u16) {
        assert(self.fish_population >= amount, errors::POND_NOT_ENOUGH_FISH);
    }

    fn assert_action_allowed(self: FishPond, current_time: u64) {
        // Assuming a cooldown of 1 hour (3600 seconds)
        assert(current_time >= self.last_action_time + 3600, errors::POND_ACTION_TOO_SOON);
    }
}
