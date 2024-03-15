// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


import "./Trader.sol";
import "./models/Coin.sol";
import "./models/Service.sol";
import "./models/CooperationRing.sol";
import "./models/FractalRing.sol";


contract Instance {
    Trader[] public traders;
    Service[] public services;
    Coin[] public coins;
    uint256 public roundCapitalization;
    uint256 public roundCapitalizationLimit;
    uint256 public roundLimit;
    uint256 public exchangeRateEther;
    uint256 public round;

    constructor(
        Service[] memory _services,
        uint256 _roundCapitalizationLimit,
        uint256 _roundLimit,
        uint256 _exchangeRateEther) {
        for (uint256 i = 0; i < _services.length; i++) {
            services.push(_services[i]);
        }
        roundCapitalization = 0;
        roundCapitalizationLimit = _roundCapitalizationLimit;
        round = 0;
        roundLimit = _roundLimit;
        exchangeRateEther = _exchangeRateEther;
    }

    function getServices() public view returns (Service[] memory) {
        return services;
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

    function submitCoin(string memory serviceName, CoinType coinType) public {
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
        Coin memory coin = Coin(trader.traderAddress(), service, coinType);
        roundCapitalization += service.price;
        if (roundCapitalization >= roundCapitalizationLimit) {
            roundProcess();
        }
        if (round >= roundLimit) {
            checkpointProcess();
        }

    }

    function roundProcess() private {
        round++;
        roundCapitalization = 0;
        // for (uint256 i = 0; i < traders.length; i++) {
        //     traders[i].roundProcess();
        // }
    }

    function checkpointProcess() private {
        round = 0;
        // for (uint256 i = 0; i < traders.length; i++) {
        //     traders[i].checkpointProcess();
        // }
    }

    function createCooperationRing(Coin memory investmentCoin) public returns (CooperationRing memory) {
        CooperationRing memory cooperationRing;
        cooperationRing.coins.push(investmentCoin);
        Coin[] memory workerCoins;
        for (uint256 i = 0; i <= coins.length; i++) {
            if (coins[i].coinType == CoinType.Worker && coins[i].service == investmentCoin.service) {
                workerCoins.push(coins[i]);
            }
        }
        // uint randomIndex = sha256(investmentCoin) % workerCoins.length;
        uint randomIndex = 0;
        cooperationRing.coins.push(workerCoins[randomIndex]);
        return cooperationRing;
    }

}