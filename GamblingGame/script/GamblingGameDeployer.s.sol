// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {GamblingGame} from "../src/GamblingGame.sol";
import "../src/access/proxy/Proxy.sol";

contract GamblingGameScript is Script {
    GamblingGame public gamblingGame;
    Proxy public proxyGamblingGame;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        address admin = msg.sender;
        address betteToken = address(0x0);

        gamblingGame = new GamblingGame();
        proxyGamblingGame = new Proxy(address(gamblingGame), admin, "");

        gamblingGame.initialize(admin, betteToken, admin, 32);
        console.log("GamblingGame deployed to:", address(proxyGamblingGame));
        console.log("GamblingGame implementation deployed to:", address(gamblingGame));

        vm.stopBroadcast();
    }
}
