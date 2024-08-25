// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 10;
const REWARD: u8 = 4;
const RARITY: u8 = 95;

impl Bluefin of TunaTrait {
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
