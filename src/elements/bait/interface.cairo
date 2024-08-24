#[derive(Drop, Copy)]
trait BaitTrait {
    fn size() -> u8;
    fn attract_power() -> u8;
    fn durability() -> u8;
    fn rare_fish_bonus() -> u8;
}
