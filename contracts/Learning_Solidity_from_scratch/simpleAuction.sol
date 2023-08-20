// SPDX-License-Identifier: MIT
// Noted in document: https://tinyurl.com/3ernaf29

pragma solidity >0.7.0;

contract simpleAution{
    // Variable
    address payable public beneficiary;
    uint public autionEndTime;
    uint public highestBid;
    address public highestBidder;
    bool ended = false;

    mapping (address => uint) public pendingReturns;
    event highestBidIncrease(address bidder, uint amount);
    event autionEnded(address winner, uint amount);

    // _beneficiary: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    constructor (uint _biddingTime, address payable _beneficiary) {
        beneficiary = _beneficiary;
        autionEndTime = block.timestamp + _biddingTime;
    }

    // Function
    function bid() public payable {
        if (block.timestamp > autionEndTime) {
            revert("Auction is ended");
        }

        if(msg.value <= highestBid) {
            revert("You bid amount is less than the highest bid price");
        }

        if(highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
        emit highestBidIncrease(msg.sender, msg.value);
    }

    function withdraw() public returns(bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount>0) {
            pendingReturns[msg.sender] = 0;
            if (!payable(msg.sender).send(amount)){
                pendingReturns[msg.sender]=amount;
                return false;
            }
        }
        return true;
    }


    function auctionEnd() public {
        if(ended) {
            revert("The Auction is maybe ended");
        }
        if(block.timestamp < autionEndTime) {
            revert("The Auction is not ended yet");
        }
        ended = true;
        emit autionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }

}