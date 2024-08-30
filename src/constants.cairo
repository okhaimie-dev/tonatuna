use starknet::ContractAddress;

// Fishing Pond
const DAILY_CATCH_LIMIT: u32 = 1000;
const MAX_SIZE: u32 = 100;

// Player
const MAX_DAILY_FISHING_ATTEMPTS: u8 = 5;

// Game
// For Actual Play
// const REEL_DURATION: u64 = 10 * 60; // 10 minutes
// const CATCH_DURATION: u64 = 20 * 60; // 20 minutes after commitments are made

// For test
const REEL_DURATION: u64 = 10;
const CATCH_DURATION: u64 = 10;

const ETH_TO_WEI: u256 = 1_000_000_000_000_000_000;

const BAIT_PRICE: u256 = 10;

fn TOKEN_ADDRESS() -> ContractAddress { starknet::contract_address_const::<0x1234>() }
fn GAME_CONTRACT_ADDRESS() -> ContractAddress { starknet::contract_address_const::<0x5678>() }

const SPAWNING_DELAY: u64 = 10 * 60; // 10 minutes
const INITIAL_FISH_NUM_PER_PLAYER: u32 = 3;
