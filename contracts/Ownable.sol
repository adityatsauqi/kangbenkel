// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

contract Ownable {

    address payable public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier isOwner() {
        require(owner == msg.sender, "Permintaan anda tidak dapat dipenuhi");
        _;
    }
}