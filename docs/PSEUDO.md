# Tables

```rust
struct Position {
  id: u256, // fish/fisherman id
  x: i32,
  y: i32,
  xDest: i32,
  yDest: i32,
  last_updated: u32,
}

struct Fisherman {
  id: u256, // fisherman id
  owner: address,
}

struct BaitBalance {
  id: u256, // fisherman id
  value: u32,
}

struct FishBalance {
  id: u256, // fisherman id
  amount: u32,
}

struct Fish {
  id: u256, // fish id
  size: u32,
  spawn_timestamp: u32,
}

// Fisherman -> Fish hidden until reveal
struct Commitment {
  id: u256, // fisherman id
  value: u256,
  timestamp: u32,
}

// Fisherman -> Fish revealed
struct Reveal {
  id: u256, // fisherman id
  fish_id: u256,
}

struct RevealCount {
  id: u256, // fish id
  timestamp: u32,
  count: u32,
}


```

# Logic

```rust
fn play(id: u256) {
  if is_fish_id(id) revert
  if !is_available_id(id) revert

  transfer(sender, game, PRICE)

fisherman[id] = Fisherman {
    id: id,
    owner: sender
  }
  baitBalance[id] = BaitBalance {
    id: id,
    value: PRICE
  }
  position[id] = Position {
    id: id,
    x: 0,
    y: 0,
    xDest: 0,
    yDest: 0,
    last_updated: now()
  }

  spawn_fishes()
}

fn move(id: u256, xDest: i32, yDest: i32) {
  if is_fish_id(id) revert
  if is_available_id(id) revert
  if owner(id) != sender revert

  (x, y) = get_position(id)

  position[id] = Position {
    id: id,
    x: x,
    y: y,
    xDest: xDest,
    yDest: yDest,
    last_updated: now()
  }
}

// Fisherman -> hidden fish commiment
fn cast(id: u256, commitment: felt252, nonce: u32) { // random hash hash(fish_id, salt) 
  if is_fish_id(id) revert
  if owner(id) != sender revert
  
  
  baitBalance[id] -= 1;
  commitment[id] = Commitment {
    id: id,
    value: commitment,
    nonce: nonce
    timestamp: now()
  }
}

// Reveal fisherman -> fish
fn reel(id: u256, fish_id: u256, salt: u256) {
  if is_fish_id(id) revert
  if !is_fish_id(fish_id) revert
  if owner(id) != sender revert
  if hash(fish_id, salt) != commitment[id].value revert

  // fish already caught
  if fish[fish_id].size == 0 {
    delete commitment[id]
    return;
  }

  fish[fish_id].size += 1
  reveal[id] = Reveal {
    id: id,
    fish_id: fish_id
  }

  // within reel duration of first reel
  if revealCount[fish_id].timestamp + REEL_DURATION < now() {
    revealCount[fish_id].count += 1
  } else if revealCount[fish_id].count > 1 {
  // if more than 2 reel, previous attempt failed, so reset reel
    revealCount[fish_id].count = 1
  }
  // else only 1 reel and fish was caught
  delete commitment[id]
}

// catch fish if you are the only one who reeled after reel duration
fn catch(id: u256, fish_id: u256) {
  if is_fish_id(id) revert
  if !is_fish_id(fish_id) revert
  if owner(id) != sender revert
  if reveal[id].fish_id != fish_id revert

  // fish already caught
  if fish[fish_id].size == 0 revert

  fishBalance[id].amount += fish[fish_id].size
  delete fish[fish_id]
}

fn sellFishes(id: u256) {
  if is_fish_id(id) revert
  if owner(id) != sender revert

  // calculate value based on fish balance and eth balance
  // formula tbd
}

fn get_position(id: u256) {
  // extrapolate position based on starting and destination position and current time
}

fn is_moving(id: u256) {
  // check if fish/fisherman is moving
}

fn is_fish_id(id: u256) {
  // set aside half of ids for fish and half for fishermen
  id < 2^255
}

fn is_available_id(id: u256) {
  // check if fisherman id is unallocated
  owner == null
}

fn spawn_fishes() {
  // could randomly spawn fish of different sizes
  // could also spawn random number of fishes
  spawn_fish(2, 0)
  spawn_fish(2, 100)
  spawn_fish(2, 200)
}

fn spawn_fish(size, spawn_delay) {
  id = request_unique_id()
  fish[id] = Fish {
    id: id,
    size: size,
    // spawn fishes over time rather than immediately
    spawn_timestamp: now() + spawn_delay
  }

  x = random_x();
  y = random_y();

  position[id] = Position {
    id: id,
    x: x,
    y: y,
    xDest: x,
    yDest: y,
    last_updated: now()
  }
}

```