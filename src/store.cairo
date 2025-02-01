use starknet::ContractAddress;
use dojo::world::WorldStorage;
use dojo::model::ModelStorage;

use micropay::models::tokens::Tokens;

#[derive(Copy, Drop)]
pub struct Store {
    world: WorldStorage,
}

#[generate_trait]
pub impl StoreImpl of StoreTrait {
    #[inline]
    fn new(world: WorldStorage) -> Store {
        Store { world: world }
    }

    #[inline]
    fn read_tokens(self: @Store, id: ContractAddress) -> Tokens {
        self.world.read_model(id)
    }

    #[inline]
    fn write_tokens(ref self: Store, tokens: @Tokens) {
        self.world.write_model(tokens)
    }
}
