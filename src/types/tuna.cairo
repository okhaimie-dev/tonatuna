// Internal imports

use tonatuna::elements::tuna;

#[derive(Copy, Drop)]
enum Tuna {
    None,
    Yellowfin,
    Bluefin,
    Albacore,
    Skipjack,
}

#[generate_trait]
impl TunaImpl of TunaTrait {
    #[inline]
    fn weight(self: Tuna) -> u16 {
        match self {
            Tuna::None => 0,
            Tuna::Yellowfin => tuna::yellowfin::Yellowfin::weight(),
            Tuna::Bluefin => tuna::bluefin::Bluefin::weight(),
            Tuna::Albacore => tuna::albacore::Albacore::weight(),
            Tuna::Skipjack => tuna::skipjack::Skipjack::weight(),
        }
    }

    #[inline]
    fn value(self: Tuna) -> u16 {
        match self {
            Tuna::None => 0,
            Tuna::Yellowfin => tuna::yellowfin::Yellowfin::value(),
            Tuna::Bluefin => tuna::bluefin::Bluefin::value(),
            Tuna::Albacore => tuna::albacore::Albacore::value(),
            Tuna::Skipjack => tuna::skipjack::Skipjack::value(),
        }
    }

    #[inline]
    fn rarity(self: Tuna) -> u8 {
        match self {
            Tuna::None => 0,
            Tuna::Yellowfin => tuna::yellowfin::Yellowfin::rarity(),
            Tuna::Bluefin => tuna::bluefin::Bluefin::rarity(),
            Tuna::Albacore => tuna::albacore::Albacore::rarity(),
            Tuna::Skipjack => tuna::skipjack::Skipjack::rarity(),
        }
    }

    #[inline]
    fn fighting_strength(self: Tuna) -> u8 {
        match self {
            Tuna::None => 0,
            Tuna::Yellowfin => tuna::yellowfin::Yellowfin::fighting_strength(),
            Tuna::Bluefin => tuna::bluefin::Bluefin::fighting_strength(),
            Tuna::Albacore => tuna::albacore::Albacore::fighting_strength(),
            Tuna::Skipjack => tuna::skipjack::Skipjack::fighting_strength(),
        }
    }
}

impl IntoTunaFelt252 of core::Into<Tuna, felt252> {
    #[inline]
    fn into(self: Tuna) -> felt252 {
        match self {
            Tuna::None => 'NONE',
            Tuna::Yellowfin => 'YELLOWFIN',
            Tuna::Bluefin => 'BLUEFIN',
            Tuna::Albacore => 'ALBACORE',
            Tuna::Skipjack => 'SKIPJACK',
        }
    }
}

impl IntoTunaU8 of core::Into<Tuna, u8> {
    #[inline]
    fn into(self: Tuna) -> u8 {
        match self {
            Tuna::None => 0,
            Tuna::Yellowfin => 1,
            Tuna::Bluefin => 2,
            Tuna::Albacore => 3,
            Tuna::Skipjack => 4,
        }
    }
}

impl IntoU8Tuna of core::Into<u8, Tuna> {
    #[inline]
    fn into(self: u8) -> Tuna {
        let tuna_type: felt252 = self.into();
        match tuna_type {
            0 => Tuna::None,
            1 => Tuna::Yellowfin,
            2 => Tuna::Bluefin,
            3 => Tuna::Albacore,
            4 => Tuna::Skipjack,
            _ => Tuna::None,
        }
    }
}

impl TunaPrint of core::debug::PrintTrait<Tuna> {
    #[inline]
    fn print(self: Tuna) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
