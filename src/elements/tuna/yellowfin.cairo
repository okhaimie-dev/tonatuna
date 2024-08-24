// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 25;
const VALUE: u8 = 2;
const RARITY: u8 = 60;

impl Yellowfin of TunaTrait {
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
