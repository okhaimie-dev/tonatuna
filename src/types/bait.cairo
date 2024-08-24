use tonatuna::elements::bait;

#[derive(Copy, Drop)]
enum Bait {
    None,
    Mackerel,
    Mullet,
    Squid,
    Poppers,
}

#[generate_trait]
impl BaitImpl of BaitTrait {
    #[inline]
    fn size(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Mackerel => bait::mackerel::Mackerel::size(),
            Bait::Mullet => bait::mullet::Mullet::size(),
            Bait::Squid => bait::squid::Squid::size(),
            Bait::Poppers => bait::poppers::Poppers::size(),
        }
    }

    #[inline]
    fn attract_power(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Mackerel => bait::mackerel::Mackerel::attract_power(),
            Bait::Mullet => bait::mullet::Mullet::attract_power(),
            Bait::Squid => bait::squid::Squid::attract_power(),
            Bait::Poppers => bait::poppers::Poppers::attract_power(),
        }
    }

    #[inline]
    fn durability(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Mackerel => bait::mackerel::Mackerel::durability(),
            Bait::Mullet => bait::mullet::Mullet::durability(),
            Bait::Squid => bait::squid::Squid::durability(),
            Bait::Poppers => bait::poppers::Poppers::durability(),
        }
    }

    #[inline]
    fn rare_fish_bonus(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Mackerel => bait::mackerel::Mackerel::rare_fish_bonus(),
            Bait::Mullet => bait::mullet::Mullet::rare_fish_bonus(),
            Bait::Squid => bait::squid::Squid::rare_fish_bonus(),
            Bait::Poppers => bait::poppers::Poppers::rare_fish_bonus(),
        }
    }
}

impl IntoBaitFelt252 of core::Into<Bait, felt252> {
    #[inline]
    fn into(self: Bait) -> felt252 {
        match self {
            Bait::None => 'NONE',
            Bait::Mackerel => 'MACKEREL',
            Bait::Mullet => 'MULLET',
            Bait::Squid => 'SQUID',
            Bait::Poppers => 'POPPERS',
        }
    }
}

impl IntoBaitU8 of core::Into<Bait, u8> {
    #[inline]
    fn into(self: Bait) -> u8 {
        match self {
            Bait::None => 0,
            Bait::Mackerel => 1,
            Bait::Mullet => 2,
            Bait::Squid => 3,
            Bait::Poppers => 4,
        }
    }
}

impl IntoU8Bait of core::Into<u8, Bait> {
    #[inline]
    fn into(self: u8) -> Bait {
        let bait_type: felt252 = self.into();
        match bait_type {
            0 => Bait::None,
            1 => Bait::Mackerel,
            2 => Bait::Mullet,
            3 => Bait::Squid,
            4 => Bait::Poppers,
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
