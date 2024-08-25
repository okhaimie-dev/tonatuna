// Internal imports

use tonatuna::elements::bait::interface::BaitTrait;

// Constants

const SIZE: u8 = 1;
const ATTRACT_POWER: u8 = 3;

impl Poppers of BaitTrait {
    #[inline]
    fn size() -> u8 {
        SIZE
    }

    #[inline]
    fn attract_power() -> u8 {
        ATTRACT_POWER
    }
}
