// Internal imports

use tonatuna::elements::tuna::interface::TunaTrait;

// Constants

const WEIGHT: u8 = 10;
const VALUE: u8 = 3;
const RARITY: u8 = 70;

impl Albacore of TunaTrait {
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
