// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


import "./Trader.sol";
import "./models/Coin.sol";
import "./models/Service.sol";

contract Instance {
    Trader[] public traders;
    Service[] public services;
    uint256 public roundCapitalization;
    uint256 public roundCapitalizationLimit;
    uint256 public exchangeRateEther;

    constructor(
        Service[] memory _services,
        uint256 _roundCapitalizationLimit,
        uint256 _exchangeRateEther) {
        services = _services;
        roundCapitalization = 0;
        roundCapitalizationLimit = _roundCapitalizationLimit;
        exchangeRateEther = _exchangeRateEther;
    }

    function join() public {
        traders.push(new Trader(msg.sender));
    }

    function transferAra(address _to, uint256 _amount) public {
        // TODO: check if msg.sender is a trader
        // TODO: check if _to is a trader
        // TODO: check if msg.sender has enough balance
        for (uint256 i = 0; i < traders.length; i++) {
            if (traders[i].traderAddress() == msg.sender) {
                traders[i].withdraw(_amount);
            }
            if (traders[i].traderAddress() == _to) {
                traders[i].deposit(_amount);
            }
        }
    }

    function submitCoin(string memory serviceName) public {
        // TODO: check if msg.sender is a trader
        // TODO: check if msg.sender has enough balance
        // TODO: check if service exists
        Service memory service;
        for (uint256 i = 0; i < services.length; i++) {
            if (keccak256(abi.encodePacked(services[i].name)) == keccak256(abi.encodePacked(serviceName))) {
                service = services[i];
            }
        }
        Trader trader;
        for (uint256 i = 0; i < traders.length; i++) {
            if (traders[i].traderAddress() == msg.sender) {
                trader = traders[i];
            }
        }
        Coin memory coin = Coin(service, trader);
        roundCapitalization += service.price;
        // TODO: Handle round and checkpoint
    }
}