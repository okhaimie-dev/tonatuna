// Internal imports

use tonatuna::elements::fishing_rod::interface::FishingRodTrait;

// Constants

const STRENGTH: u8 = 6;
const DURABILITY: u8 = 6;
const CASTING_DISTANCE: u8 = 8;
const LUCK_BONUS: u8 = 4;

impl Popping of FishingRodTrait {
    #[inline]
    fn strength() -> u8 {
        STRENGTH
    }

    #[inline]
    fn durability() -> u8 {
        DURABILITY
    }

    #[inline]
    fn casting_distance() -> u8 {
        CASTING_DISTANCE
    }

    #[inline]
    fn luck_bonus() -> u8 {
        LUCK_BONUS
    }
}
