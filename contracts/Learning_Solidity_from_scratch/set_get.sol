// SPDX-License-Identifier: MIT
// Noted in document: https://tinyurl.com/3ernaf29

pragma solidity >0.7.0;

contract firstcontract{
    uint saveData;

    function set(uint x) public {
        saveData = x;
    }

    function get() public view returns (uint x) {
        return saveData;
    }
}