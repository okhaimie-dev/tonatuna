use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Player {
    #[key]
    pub id: ContractAddress,
    pub bait_balance: u32,
    pub fish_caught: u32,
    pub daily_attempts: u8,
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct FishPond {
    #[key]
    pub id: felt252,
    pub fish_population: u32,
    pub daily_catch_limit: u32,
    pub depth: u8,
    pub rare_fish_chance: u8,
    pub daily_catches: u32
}
