#[derive(Drop, Copy)]
trait FishingRodTrait {
    fn strength() -> u8;
    fn durability() -> u8;
    fn casting_distance() -> u8;
    fn luck_bonus() -> u8;
}
