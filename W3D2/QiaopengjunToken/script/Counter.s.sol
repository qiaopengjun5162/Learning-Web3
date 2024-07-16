// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {QiaopengjunToken} from "../src/QiaopengjunToken.sol";

contract QiaopengjunTokenScript is Script {
    QiaopengjunToken public qpjtoken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        qpjtoken = new QiaopengjunToken(msg.sender);

        console.log("QiaopengjunToken deployed to:", address(qpjtoken));
        console.log("QiaopengjunToken owner:", qpjtoken.owner());

        vm.stopBroadcast();
    }
}
