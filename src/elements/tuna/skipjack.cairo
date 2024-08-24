// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 5;
const VALUE: u8 = 1;
const RARITY: u16 = 30;

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
