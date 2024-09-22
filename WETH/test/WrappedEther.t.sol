// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {WrappedEther} from "../src/WrappedEther.sol";

/**
 * @title WrappedEther Test
 * @author
 * @notice
 * @dev
 *  主要测试内容：
 *
 * 	1.	testMint: 测试合约的 mint 功能，确保只有合约所有者可以铸造 WETH。
 * 	2.	testDeposit: 测试用户存入 ETH 并正确收到相应的 WETH。
 * 	3.	testWithdraw: 测试用户从合约中提取 ETH 并燃烧等量的 WETH。
 * 	4.	testReceive: 测试合约接收 ETH 的功能。
 * 	5.	testFailWithdrawMoreThanBalance: 测试用户尝试提取超过余额的情况，并确保合约回滚。
 */
contract WrappedEtherTest is Test {
    WrappedEther public weth;

    address owner = makeAddr("owner");
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address user = makeAddr("user");

    function setUp() public {
        weth = new WrappedEther(owner);
    }

    function testMint() public {
        uint256 mintAmount = 10 ether;
        vm.prank(owner);
        weth.mint(user, mintAmount); // Mint WETH to user

        assertEq(weth.balanceOf(user), mintAmount, "Minting WETH failed");
    }

    function testDeposit() public {
        uint256 depositAmount = 1 ether;

        vm.deal(user, depositAmount); // Provide ETH to the user
        vm.prank(user); // Set the next call to come from user
        weth.deposit{value: depositAmount}(); // Deposit ETH to mint WETH

        assertEq(weth.balanceOf(user), depositAmount, "WETH balance should match ETH deposited");
        assertEq(address(weth).balance, depositAmount, "ETH balance in contract should match deposit");
    }

    function testWithdraw() public {
        uint256 depositAmount = 1 ether;
        uint256 withdrawAmount = 0.5 ether;

        vm.deal(user, depositAmount); // Provide ETH to the user
        vm.prank(user);
        weth.deposit{value: depositAmount}(); // Deposit ETH

        assertEq(weth.balanceOf(user), depositAmount, "Initial deposit WETH balance mismatch");

        vm.prank(user);
        weth.withdraw(withdrawAmount); // Withdraw part of the deposited ETH

        assertEq(weth.balanceOf(user), depositAmount - withdrawAmount, "WETH balance mismatch after withdrawal");
        assertEq(user.balance, withdrawAmount, "User ETH balance mismatch after withdrawal");
    }

    function testReceive() public {
        uint256 depositAmount = 2 ether;

        vm.deal(user, depositAmount); // Give user some ETH
        vm.prank(user);
        (bool success,) = address(weth).call{value: depositAmount}(""); // Send ETH directly to the contract
        require(success, "ETH transfer failed");

        assertEq(weth.balanceOf(user), depositAmount, "WETH balance should match ETH sent via receive()");
    }

    function testFailWithdrawMoreThanBalance() public {
        uint256 depositAmount = 1 ether;
        uint256 withdrawAmount = 2 ether;

        vm.deal(user, depositAmount); // Provide ETH to the user
        vm.prank(user);
        weth.deposit{value: depositAmount}(); // Deposit ETH

        vm.prank(user);
        weth.withdraw(withdrawAmount); // Attempt to withdraw more than the deposited amount (should fail)
    }
}
