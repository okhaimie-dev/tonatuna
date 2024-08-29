// Internal imports

// use tonatuna::elements::tuna;

#[derive(Copy, Drop)]
enum FishStatus {
    None,
    Swiming,
    Caught
}

#[generate_trait]
impl FishStatusImpl of FishStatusTrait {}

impl IntoFishStatusFelt252 of core::Into<FishStatus, felt252> {
    #[inline]
    fn into(self: FishStatus) -> felt252 {
        match self {
            FishStatus::None => 'NONE',
            FishStatus::Swiming => 'SWIMING',
            FishStatus::Caught => 'CAUGHT'
        }
    }
}

impl IntoFishStatusU8 of core::Into<FishStatus, u8> {
    #[inline]
    fn into(self: FishStatus) -> u8 {
        match self {
            FishStatus::None => 0,
            FishStatus::Swiming => 1,
            FishStatus::Caught => 2
        }
    }
}

impl IntoU8FishStatus of core::Into<u8, FishStatus> {
    #[inline]
    fn into(self: u8) -> FishStatus {
        let fish_status: felt252 = self.into();
        match fish_status {
            0 => FishStatus::None,
            1 => FishStatus::Swiming,
            2 => FishStatus::Caught,
            _ => FishStatus::None
        }
    }
}

impl FishStatusPrint of core::debug::PrintTrait<FishStatus> {
    #[inline]
    fn print(self: FishStatus) {
        let felt: felt252 = self.into();
        felt.print();
    }
}

