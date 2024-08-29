// use debug::PrintTrait;
use starknet::{ContractAddress};

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};


// player need to allow contract to transfer funds first
// ierc20::approve(contract_address, max(wager.value, wager.fee));
fn transfer_fund(world: IWorldDispatcher, from: ContractAddress, to: ContractAddress, amount: u256) {
    let table : TableConfig = TableManagerTrait::new(world).get(challenge.table_id);
    let balance: u256 = table.ierc20().balance_of(from);
    let allowance: u256 = table.ierc20().allowance(from, to);
    assert(balance >= amount, Errors::INSUFFICIENT_BALANCE);
    if (allowance < amount) {
        table.ierc20().approve(to, amount);
    }
    table.ierc20().transfer(to, amount);
}

fn deposit_wager_fees(world: IWorldDispatcher, challenge: Challenge, from: ContractAddress, to: ContractAddress) {
    let wager: Wager = get!(world, (challenge.duel_id), Wager);
    let total: u256 = (wager.value + wager.fee).into();
    if (total > 0) {
        let table : TableConfig = TableManagerTrait::new(world).get(challenge.table_id);
        let balance: u256 = table.ierc20().balance_of(from);
        let allowance: u256 = table.ierc20().allowance(from, to);
        assert(balance >= total, Errors::INSUFFICIENT_BALANCE);
        assert(allowance >= total, Errors::NO_ALLOWANCE);
        table.ierc20().transfer_from(from, to, total);
    }
}
fn withdraw_wager_fees(world: IWorldDispatcher, challenge: Challenge, to: ContractAddress) {
    let wager: Wager = get!(world, (challenge.duel_id), Wager);
    let total: u256 = (wager.value + wager.fee).into();
    if (total > 0) {
        let table : TableConfig = TableManagerTrait::new(world).get(challenge.table_id);
        let balance: u256 = table.ierc20().balance_of(starknet::get_contract_address());
        assert(balance >= total, Errors::WITHDRAW_NOT_AVAILABLE); // should never happen!
        table.ierc20().transfer(to, total);
    }
}