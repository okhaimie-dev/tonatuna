// Internal imports

use tonatuna::models::index::Player;

#[generate_trait]
impl PlayerImpl of PlayerTrait {
    fn new(id: ContractAddress) -> Player {
        Player { id, bait_balance: 10, fish_caught: 0, daily_attempts: 0, }
    }

    fn add_bait(ref self: Player, amount: u32) {
        self.bait_balance += amount;
    }

    fn reset_daily_attempts(ref self: Player) {
        self.daily_attempts = 0;
    }
}
