/*
/// Module: gadus
module gadus::gadus;
*/

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


module gadus::gadus;

use sui::package;
use sui::kiosk;

    public struct Item has key, store {
        id: UID,
        name: std::string::String,
        decription: std::string::String
    }

    public struct GADUS has drop{}


fun init(otw: GADUS, ctx: &mut TxContext){

    let gadus = package::claim(otw, ctx);
    transfer::public_transfer(gadus, tx_context::sender(ctx));
}

public entry fun create_kiosk(ctx: &mut TxContext){
    let (kiosk,  cap) = kiosk::new(ctx);
    transfer::public_share_object(kiosk);
    transfer::public_transfer(cap, tx_context::sender(ctx))
}

public entry fun mint_item(name: std::string::String, decription: std::string::String, ctx: &mut TxContext){
    let x = Item {
        id: object::new(ctx),
        name,
        decription,
    };
    transfer::public_transfer(x, tx_context::sender(ctx))
}