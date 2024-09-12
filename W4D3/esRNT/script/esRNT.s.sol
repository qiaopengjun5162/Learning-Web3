// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {esRNT} from "../src/esRNT.sol";

contract esRNTScript is Script {
    esRNT public es;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        es = new esRNT();

        vm.stopBroadcast();
    }
}
