// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Trader {
    address public traderAddress;
    uint public balance;

    constructor(address _traderAddress) {
        traderAddress = _traderAddress;
        balance = 100;
        // TODO: Initial ARA mechanism
    }

    // TODO: Only Instance contract should call this function
    function deposit(uint amount) public {
        balance += amount;
    }

    function withdraw(uint amount) public {
        balance -= amount;
    }
}
