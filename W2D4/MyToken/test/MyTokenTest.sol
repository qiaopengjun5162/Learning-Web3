// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public mytoken;

    address public owner = address(0x123);
    address public alice = address(0x456);
    uint256 public totalSupply = 1e10 * 1e18;

    function setUp() public {
        mytoken = new MyToken("MyToken", "MTK");
        console.log("Setup complete");
    }

    function testBalance() public view {
        assertEq(mytoken.balanceOf(owner), 0);
        assertEq(mytoken.balanceOf(alice), 0);
        assertEq(mytoken.balanceOf(address(this)), totalSupply);
    }

    function testTransfer() public {
        mytoken.transfer(alice, 100);
        assertEq(mytoken.balanceOf(owner), 0);
        assertEq(mytoken.balanceOf(alice), 100);
    }

    function testName() public view {
        assertEq(mytoken.name(), "MyToken");
    }
    function testSymbol() public view {
        assertEq(mytoken.symbol(), "MTK");
    }
    function testDecimals() public view {
        assertEq(mytoken.decimals(), 18);
    }
    function testTotalSupply() public view {
        assertEq(mytoken.totalSupply(), totalSupply);
    }
}
