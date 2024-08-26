use tonatuna::types::vec2::Vec2;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Player {
    #[key]
    pub id: felt252,
    pub name: felt252,
    pub bait_balance: u32,
    pub fish_caught: u32,
    pub daily_attempts: u8,
    pub position: Vec2,
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct FishPond {
    #[key]
    pub id: u32,
    pub fish_population: u32,
    pub daily_catch_limit: u32,
    pub rare_fish_chance: u8,
    pub daily_catches: u32
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Fish {
    #[key]
    pub fish_pond_id: u32,
    #[key]
    pub fish_id: u32,
    pub position: Vec2,
    pub weight: u32
    // pub rarity: u8,
}