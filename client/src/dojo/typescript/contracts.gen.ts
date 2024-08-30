
// Generated by dojo-bindgen on Fri, 30 Aug 2024 15:37:01 +0000. Do not modify this file manually.
// Import the necessary types from the recs SDK
// generate again with `sozo build --typescript` 
import { Account, byteArray } from "starknet";
import { DojoProvider } from "@dojoengine/core";
import * as models from "./models.gen";

export type IWorld = Awaited<ReturnType<typeof setupWorld>>;

export async function setupWorld(provider: DojoProvider) {
    // System definitions for `tonatuna-actions` contract
    function actions() {
        const contract_name = "actions";

        
        // Call the `world` system with the specified Account and calldata
        const world = async (props: { account: Account }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "world",
                        calldata: [],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `create_fish_pond` system with the specified Account and calldata
        const create_fish_pond = async (props: { account: Account }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "create_fish_pond",
                        calldata: [],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `new_player` system with the specified Account and calldata
        const new_player = async (props: { account: Account, name: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "new_player",
                        calldata: [props.name],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `reset_daily_attempts` system with the specified Account and calldata
        const reset_daily_attempts = async (props: { account: Account }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "reset_daily_attempts",
                        calldata: [],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `buy_baits` system with the specified Account and calldata
        const buy_baits = async (props: { account: Account, amount: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "buy_baits",
                        calldata: [props.amount],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `move` system with the specified Account and calldata
        const move = async (props: { account: Account, dest_pos: models.Vec2 }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "move",
                        calldata: [props.dest_pos.x,
                    props.dest_pos.y],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `spawn_fish` system with the specified Account and calldata
        const spawn_fish = async (props: { account: Account, fish_pond_id: number, time_delay: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "spawn_fish",
                        calldata: [props.fish_pond_id,
                props.time_delay],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `spawn_multiple_fishes` system with the specified Account and calldata
        const spawn_multiple_fishes = async (props: { account: Account, fish_pond_id: number, num_fish: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "spawn_multiple_fishes",
                        calldata: [props.fish_pond_id,
                props.num_fish],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `play` system with the specified Account and calldata
        const play = async (props: { account: Account, fish_pond_id: number, name: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "play",
                        calldata: [props.fish_pond_id,
                props.name],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `cast_fishing` system with the specified Account and calldata
        const cast_fishing = async (props: { account: Account, fish_pond_id: number, commitment: bigint }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "cast_fishing",
                        calldata: [props.fish_pond_id,
                props.commitment],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `reel_by_revealing` system with the specified Account and calldata
        const reel_by_revealing = async (props: { account: Account, fish_pond_id: number, fish_id: number, salt: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "reel_by_revealing",
                        calldata: [props.fish_pond_id,
                props.fish_id,
                props.salt],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

    
        // Call the `catch_the_fish` system with the specified Account and calldata
        const catch_the_fish = async (props: { account: Account, fish_pond_id: number, fish_id: number }) => {
            try {
                return await provider.execute(
                    props.account,
                    {
                        contractName: contract_name,
                        entrypoint: "catch_the_fish",
                        calldata: [props.fish_pond_id,
                props.fish_id],
                    },
                    "tonatuna"
                );
            } catch (error) {
                console.error("Error executing spawn:", error);
                throw error;
            }
        };
            

        return {
            world, create_fish_pond, new_player, reset_daily_attempts, buy_baits, move, spawn_fish, spawn_multiple_fishes, play, cast_fishing, reel_by_revealing, catch_the_fish
        };
    }

    return {
        actions: actions()
    };
}
