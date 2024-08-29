mod constants;
mod store;

mod types {
    mod vec2;
    mod tuna;
    mod fishing_rod;
    mod bait;
    mod fish_status;
    mod commit_status;
}

mod models {
    mod index;
    mod fish_pond;
    mod player;
    mod fish;
    mod commitment;
    mod reveal_history;
}

mod components {
    // mod initializable;
    mod playable;
}

mod systems {
    mod actions;
}

mod interfaces {
    mod ierc20;
}

mod elements {
    mod tuna {
        mod interface;
        mod yellowfin;
        mod bluefin;
        mod albacore;
        mod skipjack;
    }

    mod fishing_rod {
        mod interface;
        mod bent;
        mod jigging;
        mod popping;
    }

    mod bait {
        mod interface;
        mod mackerel;
        mod mullet;
        mod squid;
        mod poppers;
    }
}

mod helpers {
    // mod random;
    mod dice;
}

mod tests {
    mod test_world;
    mod setup;
}
