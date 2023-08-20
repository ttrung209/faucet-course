// SPDX-License-Identifier: MIT
// Noted in document: https://tinyurl.com/3ernaf29

pragma solidity >0.7.0;

contract struct01{
    uint public countPlayer = 0;
    mapping (address => Player) public players;
    enum Level {Beginner, Intermediate, Advance}

    struct Player {
        address addressPlayer;
        string fullName;
        Level myLevel;
        uint age;
    }

    function addPlayer(string memory fullName, uint age) public {
        players[msg.sender] = Player(msg.sender, fullName, Level.Advance, age);
        countPlayer += 1;
    }

    function getPlayerLevel(address addressPlayer) public view returns (Level) {
        return players[addressPlayer].myLevel;
    }

    function getPlayerName(address addressPlayer) public view returns(string memory) {
        return players[addressPlayer].fullName;
    }

    // Trunk C4: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // Trunk cb2: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
}