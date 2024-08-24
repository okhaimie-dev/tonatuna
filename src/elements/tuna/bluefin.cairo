// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 10;
const VALUE: u8 = 4;
const RARITY: u8 = 95;

impl Bluefin of TunaTrait {
    #[inline]
    fn weight() -> u8 {
        WEIGHT
    }

    #[inline]
    fn value() -> u8 {
        VALUE
    }

    #[inline]
    fn rarity() -> u8 {
        RARITY
    }
}
