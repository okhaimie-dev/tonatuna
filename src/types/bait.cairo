use tonatuna::elements::bait;

#[derive(Copy, Drop)]
enum Bait {
    None,
    Small,
    Medium,
    Large,
    Special,
}

#[generate_trait]
impl BaitImpl of BaitTrait {
    #[inline]
    fn size(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Small => bait::small::Small::size(),
            Bait::Medium => bait::medium::Medium::size(),
            Bait::Large => bait::large::Large::size(),
            Bait::Special => bait::special::Special::size(),
        }
    }

    #[inline]
    fn attract_power(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Small => bait::small::Small::attract_power(),
            Bait::Medium => bait::medium::Medium::attract_power(),
            Bait::Large => bait::large::Large::attract_power(),
            Bait::Special => bait::special::Special::attract_power(),
        }
    }

    #[inline]
    fn durability(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Small => bait::small::Small::durability(),
            Bait::Medium => bait::medium::Medium::durability(),
            Bait::Large => bait::large::Large::durability(),
            Bait::Special => bait::special::Special::durability(),
        }
    }

    #[inline]
    fn rare_fish_bonus(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Small => bait::small::Small::rare_fish_bonus(),
            Bait::Medium => bait::medium::Medium::rare_fish_bonus(),
            Bait::Large => bait::large::Large::rare_fish_bonus(),
            Bait::Special => bait::special::Special::rare_fish_bonus(),
        }
    }
}

impl IntoBaitFelt252 of core::Into<Bait, felt252> {
    #[inline]
    fn into(self: Bait) -> felt252 {
        match self {
            Bait::None => 'NONE',
            Bait::Small => 'SMALL',
            Bait::Medium => 'MEDIUM',
            Bait::Large => 'LARGE',
            Bait::Special => 'SPECIAL',
        }
    }
}

impl IntoBaitU8 of core::Into<Bait, u8> {
    #[inline]
    fn into(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Small => 1,
            Bait::Medium => 2,
            Bait::Large => 3,
            Bait::Special => 4,
        }
    }
}

impl IntoU8Bait of core::Into<u8, Bait> {
    #[inline]
    fn into(self: u8) -> Bait {
        let bait_type: felt252 = self.into();
        match bait_type {
            0 => Bait::None,
            1 => Bait::Small,
            2 => Bait::Medium,
            3 => Bait::Large,
            4 => Bait::Special,
            _ => Bait::None,
        }
    }
}

impl BaitPrint of core::debug::PrintTrait<Bait> {
    #[inline]
    fn print(self: Bait) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
