use tonatuna::elements::fishing_rod;

#[derive(Copy, Drop)]
enum FishingRod {
    None,
    Beginner,
    Intermediate,
    Advanced,
    Professional,
}

#[generate_trait]
impl FishingRodImpl of FishingRodTrait {
    #[inline]
    fn strength(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Beginner => fishing_rod::beginner::Beginner::strength(),
            FishingRod::Intermediate => fishing_rod::intermediate::Intermediate::strength(),
            FishingRod::Advanced => fishing_rod::advanced::Advanced::strength(),
            FishingRod::Professional => fishing_rod::professional::Professional::strength(),
        }
    }

    #[inline]
    fn durability(self: FishingRod) -> u16 {
        match self {
            FishingRod::None => 0,
            FishingRod::Beginner => fishing_rod::beginner::Beginner::durability(),
            FishingRod::Intermediate => fishing_rod::intermediate::Intermediate::durability(),
            FishingRod::Advanced => fishing_rod::advanced::Advanced::durability(),
            FishingRod::Professional => fishing_rod::professional::Professional::durability(),
        }
    }

    #[inline]
    fn casting_distance(self: FishingRod) -> u16 {
        match self {
            FishingRod::None => 0,
            FishingRod::Beginner => fishing_rod::beginner::Beginner::casting_distance(),
            FishingRod::Intermediate => fishing_rod::intermediate::Intermediate::casting_distance(),
            FishingRod::Advanced => fishing_rod::advanced::Advanced::casting_distance(),
            FishingRod::Professional => fishing_rod::professional::Professional::casting_distance(),
        }
    }

    #[inline]
    fn luck_bonus(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Beginner => fishing_rod::beginner::Beginner::luck_bonus(),
            FishingRod::Intermediate => fishing_rod::intermediate::Intermediate::luck_bonus(),
            FishingRod::Advanced => fishing_rod::advanced::Advanced::luck_bonus(),
            FishingRod::Professional => fishing_rod::professional::Professional::luck_bonus(),
        }
    }
}

impl IntoFishingRodFelt252 of core::Into<FishingRod, felt252> {
    #[inline]
    fn into(self: FishingRod) -> felt252 {
        match self {
            FishingRod::None => 'NONE',
            FishingRod::Beginner => 'BEGINNER',
            FishingRod::Intermediate => 'INTERMEDIATE',
            FishingRod::Advanced => 'ADVANCED',
            FishingRod::Professional => 'PROFESSIONAL',
        }
    }
}

impl IntoFishingRodU8 of core::Into<FishingRod, u8> {
    #[inline]
    fn into(self: FishingRod) -> u8 {
        match self {
            FishingRod::None => 0,
            FishingRod::Beginner => 1,
            FishingRod::Intermediate => 2,
            FishingRod::Advanced => 3,
            FishingRod::Professional => 4,
        }
    }
}

impl IntoU8FishingRod of core::Into<u8, FishingRod> {
    #[inline]
    fn into(self: u8) -> FishingRod {
        let rod_type: felt252 = self.into();
        match rod_type {
            0 => FishingRod::None,
            1 => FishingRod::Beginner,
            2 => FishingRod::Intermediate,
            3 => FishingRod::Advanced,
            4 => FishingRod::Professional,
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
