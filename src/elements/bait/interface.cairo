#[derive(Drop, Copy)]
trait BaitTrait {
    fn size() -> u8;
    fn attract_power() -> u8;
}
