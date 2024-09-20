// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {WrappedEther} from "../src/WrappedEther.sol";

contract WrappedEtherTest is Test {
    WrappedEther public weth;

    address owner = makeAddr("owner");

    function setUp() public {
        weth = new WrappedEther(owner);
    }
}
