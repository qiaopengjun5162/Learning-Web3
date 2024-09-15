// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {NFTSwap} from "../src/NFTSwap.sol";

contract NFTSwapScript is Script {
    NFTSwap public nftswap;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        nftswap = new NFTSwap();
        console.log("NFTSwap deployed to:", address(nftswap));

        vm.stopBroadcast();
    }
}
