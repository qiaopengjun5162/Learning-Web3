// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {WrappedEther} from "../src/WrappedEther.sol";

contract WrappedEtherScript is Script {
    WrappedEther public weth;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        weth = new WrappedEther(address(0x1));

        vm.stopBroadcast();
    }
}
