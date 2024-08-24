#[derive(Drop, Copy)]
trait TunaTrait {
    fn weight() -> u8;
    fn value() -> u8;
    fn rarity() -> u8;
}
