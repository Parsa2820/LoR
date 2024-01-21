// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


import "./Service.sol";

struct Coin {
    address owner;
    Service service;
    CoinType coinType;
}

enum CoinType {
    Investor,
    Worker
}