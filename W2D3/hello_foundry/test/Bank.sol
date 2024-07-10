// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../src/Bank.sol";

contract BankTest is Test {
    Bank public bank;
    address public user;

    event Deposit(address indexed user, uint amount);

    // setUp()：在每个测试之前运行，部署一个新的 Bank 合约并为 user 账号分配 10 个 ETH。
    function setUp() public {
        bank = new Bank();
        user = address(0x123);
        vm.deal(user, 10 ether);
    }

    // testInitialBalance()：验证初始余额为 0。
    function testInitialBalance() public view {
        assertEq(bank.balanceOf(user), 0);
    }

    // testDepositETH()：测试存入 1 个 ETH 并验证余额。
    function testDepositETH() public {
        vm.prank(user);
        bank.depositETH{value: 1 ether}();

        assertEq(bank.balanceOf(user), 1 ether);
    }

    // function testDepositRandomETH(uint256 amount) public {
    function testDepositRandomETH(uint96 amount) public {
        vm.assume(amount > 0); // Skip tests where amount is 0
        vm.assume(amount <= address(user).balance); // Ensure the user has enough balance

        vm.prank(user);
        bank.depositETH{value: amount}();

        assertEq(bank.balanceOf(user), amount);
    }

    function testFailDepositRandomETH(uint256 amount) public {
        vm.assume(amount > 0); // Skip tests where amount is 0
        vm.assume(amount <= address(user).balance); // Ensure the user has enough balance

        vm.prank(user);
        vm.expectRevert("Deposit amount must be greater than 0");
        bank.depositETH{value: amount}();
    }

    // testFailDepositZeroETH()：测试存入 0 个 ETH 应该失败。
    function testFailDepositZeroETH1() public {
        vm.prank(user);
        bank.depositETH{value: 0 ether}();

        assertEq(bank.balanceOf(user), 0);
    }

    // testMultipleDeposits()：测试多次存入 ETH 并验证最终余额。
    function testMultipleDeposits() public {
        vm.prank(user);
        bank.depositETH{value: 1 ether}();
        vm.prank(user);
        bank.depositETH{value: 2 ether}();

        assertEq(bank.balanceOf(user), 3 ether);
    }

    // testMultipleUsers()：测试多个用户存入 ETH 并验证各自的余额。
    function testMultipleUsers() public {
        address user1 = address(0x456);
        vm.deal(user1, 10 ether);

        vm.prank(user);
        bank.depositETH{value: 1 ether}();
        vm.prank(user1);
        bank.depositETH{value: 2 ether}();

        assertEq(bank.balanceOf(user), 1 ether);
        assertEq(bank.balanceOf(user1), 2 ether);
    }

    function testDepositETHEvent() public {
        vm.prank(user);
        vm.expectEmit(true, true, true, true);
        emit Deposit(user, 1 ether);
        bank.depositETH{value: 1 ether}();
    }
}
