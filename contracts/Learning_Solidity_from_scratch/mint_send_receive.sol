// SPDX-License-Identifier: MIT
// Noted in document: https://tinyurl.com/3ernaf29

pragma solidity >0.7.0;

contract mint_send_receive {
    address public minter;
    mapping (address => uint) public balances;

    event sent (address from, address to, uint amount);

    constructor (){
        minter = msg.sender;
    }

    function mint (address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Not enough money in your account");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit sent(msg.sender, receiver, amount);
    }

// Sender: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// Receiver: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
}

