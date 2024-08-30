use starknet::ContractAddress;

//
// https://github.com/dojoengine/origami/blob/e2057806db65709bbd68c1562a83181affaff4f3/token/src/erc20/interface.cairo
//

#[starknet::interface]
trait IERC20<TState> {
    fn transfer_from(
        ref self: TState, sender: ContractAddress, recipient: ContractAddress, amount: u256
    ) -> bool;
}

#[inline(always)]
fn ierc20(contract_address: ContractAddress) -> IERC20Dispatcher {
    assert(contract_address.is_non_zero(), 'ierc20(): null address');
    (IERC20Dispatcher { contract_address })
}
