// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 25;
const VALUE: u8 = 2;
const RARITY: u16 = 60;

impl Skipjack of SkipjackTrait {
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
