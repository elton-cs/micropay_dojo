use starknet::ContractAddress;

#[derive(Copy, Drop, Serde, Debug)]
#[dojo::model]
pub struct Tokens {
    #[key]
    pub id: ContractAddress,
    pub balance: u32,
}
