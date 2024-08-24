// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 10;
const VALUE: u8 = 4;
const RARITY: u16 = 95;

impl Bluefin of BluefinTrait {
    #[inline]
    fn weight() -> u8 {
        WEIGHT
    }

    #[inline]
    fn value() -> u8 {
        VALUE
    }

    #[inline]
    fn rarity() -> u16 {
        RARITY
    }
}
