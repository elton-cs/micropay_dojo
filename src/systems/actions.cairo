
// define the interface
#[starknet::interface]
trait IActions<T> {
    fn increment(ref self: T);
}

// dojo decorator
#[dojo::contract]
pub mod actions {
    use super::{IActions};
    use starknet::{get_caller_address};

    use micropay::components::tokens::TokenComponent;
   
    #[storage]
    struct Storage {
        #[substorage(v0)]
        token_storage: TokenComponent::Storage,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        TokenEvent: TokenComponent::Event,
    }

    component!(path: TokenComponent, storage: token_storage, event: TokenEvent);
    impl token_impl = TokenComponent::BaseImpl<ContractState>;

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn increment(ref self: ContractState) {
            let mut world = self.world_default();
            let user_address = get_caller_address();
            let _user_tokens = token_impl::add_tokens(world, user_address, 1);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        /// Use the default namespace "squares". This function is handy since the ByteArray
        /// can't be const.
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage {
            self.world(@"micropay")
        }
    }
}
