import { AccountInterface } from "starknet";
import { uuid } from "@latticexyz/utils";
import { ClientComponents } from "./createClientComponents";
import { getEvents, setComponentsFromEvents } from "@dojoengine/utils";
import type { IWorld } from "./typescript/contracts.gen";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  { client }: { client: IWorld },
  contractComponents: ClientComponents,
) {
  const create_fish_pond = async (account: AccountInterface) => {
    try {
      const { transaction_hash } = await client.actions.create_fish_pond({
        account: account as any, // or as Account if you have the Account type imported
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

  return {
    create_fish_pond,
  };
}
