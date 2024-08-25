use tonatuna::elements::fishing_rod;

#[derive(Copy, Drop)]
enum FishingRod {
    None,
    Bent,
    Popping,
    Jigging,
}

#[generate_trait]
impl FishingRodImpl of FishingRodTrait {
    #[inline]
    fn strength(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Bent => fishing_rod::bent::Bent::strength(),
            FishingRod::Popping => fishing_rod::popping::Popping::strength(),
            FishingRod::Jigging => fishing_rod::jigging::Jigging::strength(),
        }
    }

    #[inline]
    fn durability(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Bent => fishing_rod::bent::Bent::durability(),
            FishingRod::Popping => fishing_rod::popping::Popping::durability(),
            FishingRod::Jigging => fishing_rod::jigging::Jigging::durability(),
        }
    }

    #[inline]
    fn casting_distance(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Bent => fishing_rod::bent::Bent::casting_distance(),
            FishingRod::Popping => fishing_rod::popping::Popping::casting_distance(),
            FishingRod::Jigging => fishing_rod::jigging::Jigging::casting_distance(),
        }
    }

    #[inline]
    fn luck_bonus(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Bent => fishing_rod::bent::Bent::luck_bonus(),
            FishingRod::Popping => fishing_rod::popping::Popping::luck_bonus(),
            FishingRod::Jigging => fishing_rod::jigging::Jigging::luck_bonus(),
        }
    }
}

impl IntoFishingRodFelt252 of core::Into<FishingRod, felt252> {
    #[inline]
    fn into(self: FishingRod) -> felt252 {
        match self {
            FishingRod::None => 'NONE',
            FishingRod::Bent => 'BENT',
            FishingRod::Popping => 'POPPING',
            FishingRod::Jigging => 'JIGGING',
        }
    }
}

impl IntoFishingRodU8 of core::Into<FishingRod, u8> {
    #[inline]
    fn into(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Bent => 1,
            FishingRod::Popping => 2,
            FishingRod::Jigging => 3,
        }
    }
}

impl IntoU8FishingRod of core::Into<u8, FishingRod> {
    #[inline]
    fn into(self: u8) -> FishingRod {
        let rod_type: felt252 = self.into();
        match rod_type {
            0 => FishingRod::None,
            1 => FishingRod::Bent,
            2 => FishingRod::Popping,
            3 => FishingRod::Jigging,
            _ => FishingRod::None,
        }
    }
}

impl FishingRodPrint of core::debug::PrintTrait<FishingRod> {
    #[inline]
    fn print(self: FishingRod) {
        let felt: felt252 = self.into();
        felt.print();
    }
}
