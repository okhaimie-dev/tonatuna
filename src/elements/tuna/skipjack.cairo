// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 5;
const REWARD: u8 = 1;
const RARITY: u8 = 30;

impl Skipjack of TunaTrait {
    #[inline]
    fn weight() -> u8 {
        WEIGHT
    }

    #[inline]
    fn reward() -> u8 {
        REWARD
    }

    #[inline]
    fn rarity() -> u8 {
        RARITY
    }
}
