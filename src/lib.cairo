mod systems {
    mod actions;
}

mod types {
    mod tuna;
    mod fishing_rod;
    mod bait;
}

mod components {
    mod playable;
}

mod models {
    mod index;
    mod fish_pond;
    mod player;
}

mod tests {
    mod test_world;
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
        mod beginner;
        mod intermediate;
        mod advanced;
        mod professional;
    }

    mod bait {
        mod interface;
        mod small;
        mod medium;
        mod large;
        mod special;
    }
}
