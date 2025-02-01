#[starknet::component]
pub mod TokenComponent {
    use starknet::{ContractAddress};
    use micropay::store::{StoreTrait};
    use dojo::world::WorldStorage;

    #[storage]
    pub struct Storage {}

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {}

    #[generate_trait]
    pub impl BaseImpl<T, +HasComponent<T>> of BaseTrait<T> {
        // only for dojo_init
        // fn init_bomba(world: WorldStorage) {
            // let mut store = StoreTrait::new(world);
            // let mut bomba = BombaTrait::new();
            // store.write_bomba(@bomba);
        // }

        // player callable
        fn add_tokens(world: WorldStorage, user_address: ContractAddress, amount: u32) {
            let mut store = StoreTrait::new(world);
            let mut user_tokens = store.read_tokens(user_address);
            user_tokens.balance += amount;

            store.write_tokens(@user_tokens);
        }

    }
}
