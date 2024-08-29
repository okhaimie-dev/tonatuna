use starknet::{ContractAddress, ClassHash};
use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait, Resource};



mod SELECTORS {
    const ADMIN: felt252 = selector_from_tag!("pistols-admin");
    const ACTIONS: felt252 = selector_from_tag!("pistols-actions");
    const MINTER: felt252 = selector_from_tag!("pistols-minter");
    const TOKEN_DUELIST: felt252 = selector_from_tag!("pistols-token_duelist");
    const LORDS_MOCK: felt252 = selector_from_tag!("pistols-lords_mock");
}

#[generate_trait]
impl WorldSystemsTraitImpl of WorldSystemsTrait {
    fn contract_address(self: IWorldDispatcher, selector: felt252) -> ContractAddress {
        if let Resource::Contract((_, contract_address)) = self.resource(selector) {
            (contract_address)
        } else {
            (starknet::contract_address_const::<0x0>())
        }
    }

    //
    // // system addresses
    // fn token_duelist_address(self: IWorldDispatcher) -> ContractAddress {
    //     (self.contract_address(SELECTORS::TOKEN_DUELIST))
    // }

    // //
    // // dispatchers
    // fn admin_dispatcher(self: IWorldDispatcher) -> IAdminDispatcher {
    //     (IAdminDispatcher{ contract_address: self.contract_address(SELECTORS::ADMIN) })
    // }
    // fn actions_dispatcher(self: IWorldDispatcher) -> IActionsDispatcher {
    //     (IActionsDispatcher{ contract_address: self.contract_address(SELECTORS::ACTIONS) })
    // }
    // fn minter_dispatcher(self: IWorldDispatcher) -> IMinterDispatcher {
    //     (IMinterDispatcher{ contract_address: self.contract_address(SELECTORS::MINTER) })
    // }
    // fn token_duelist_dispatcher(self: IWorldDispatcher) -> ITokenDuelistDispatcher {
    //     (ITokenDuelistDispatcher{ contract_address: self.contract_address(SELECTORS::TOKEN_DUELIST) })
    // }

    // // validators
    // fn is_minter_contract(self: IWorldDispatcher, address: ContractAddress) -> bool {
    //     (address == self.contract_address(SELECTORS::MINTER))
    // }
}