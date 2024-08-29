import { Account } from "starknet";
import { ClientComponents } from "./createClientComponents";
import { getEvents, setComponentsFromEvents } from "@dojoengine/utils";
import type { IWorld } from "./typescript/contracts.gen";
import { Vec2 } from "./typescript/models.gen";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  { client }: { client: IWorld },
  contractComponents: ClientComponents,
) {
  const create_fish_pond = async (account: Account) => {
    try {
      const { transaction_hash } = await client.actions.create_fish_pond({
        account,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );

      // Wait for the indexer to update the entity
      // By doing this we keep the optimistic UI in sync with the actual state
    } catch (e) {
      console.log(e);
    }
  };

  const new_player = async (account: Account, name: bigint) => {
    try {
      const { transaction_hash } = await client.actions.new_player({
        account,
        name,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );

      // Wait for the indexer to update the entity
      // By doing this we keep the optimistic UI in sync with the actual state
    } catch (e) {
      console.log(e);
    }
  };

  const move = async (account: Account, dest_pos: Vec2) => {
    try {
      const { transaction_hash } = await client.actions.move({
        account,
        dest_pos,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );

      // Wait for the indexer to update the entity
      // By doing this we keep the optimistic UI in sync with the actual state
    } catch (e) {
      console.log(e);
    }
  };

  const spawn_fish = async (
    account: Account,
    fish_pond_id: number,
    fish_id: number,
  ) => {
    try {
      const { transaction_hash } = await client.actions.spawn_fish({
        account,
        fish_pond_id,
        fish_id,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );
    } catch (e) {
      console.log(e);
    }
  };

  const spawn_multiple_fishes = async (
    account: Account,
    fish_pond_id: number,
    num_fish: number,
  ) => {
    try {
      const { transaction_hash } = await client.actions.spawn_multiple_fishes({
        account,
        fish_pond_id,
        num_fish,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );
    } catch (e) {
      console.log(e);
    }
  };

  const cast_fishing = async (
    account: Account,
    fish_pond_id: number,
    commitment: bigint,
  ) => {
    try {
      const { transaction_hash } = await client.actions.cast_fishing({
        account,
        fish_pond_id,
        commitment,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );
    } catch (e) {
      console.log(e);
    }
  };

  const reel_by_revealing = async (
    account: Account,
    player_id: bigint,
    fish_pond_id: number,
    fish_id: number,
    salt: number,
  ) => {
    try {
      const { transaction_hash } = await client.actions.reel_by_revealing({
        account,
        player_id,
        fish_pond_id,
        fish_id,
        salt,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );
    } catch (e) {
      console.log(e);
    }
  };

  const catch_the_fish = async (
    account: Account,
    player_id: bigint,
    fish_pond_id: number,
    fish_id: number,
    salt: number,
  ) => {
    try {
      const { transaction_hash } = await client.actions.catch_the_fish({
        account,
        player_id,
        fish_pond_id,
        fish_id,
        salt,
      });

      setComponentsFromEvents(
        contractComponents,
        getEvents(
          await account.waitForTransaction(transaction_hash, {
            retryInterval: 100,
          }),
        ),
      );
    } catch (e) {
      console.log(e);
    }
  };

  return {
    create_fish_pond,
    new_player,
    move,
    spawn_fish,
    spawn_multiple_fishes,
    cast_fishing,
    reel_by_revealing,
    catch_the_fish,
  };
}
