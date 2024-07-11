// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bank} from "../src/Bank.sol";

contract BankTest is Test {
    Bank public bank;
    address public user;
    address[] users;

    event Deposit(address indexed user, uint amount);

    // setUp()：在每个测试之前运行，部署一个新的 Bank 合约并为 user 账号分配 10 个 ETH。
    function setUp() public {
        bank = new Bank();
        user = address(0x123);
        vm.deal(user, 10 ether);

        // 初始化一些用户地址
        for (uint256 i = 0; i < 10; i++) {
            address test_user = address(
                uint160(uint256(keccak256(abi.encodePacked(i))))
            );
            users.push(test_user);
            vm.deal(test_user, 100 ether); // 分配以太币给用户
        }
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
    function testFailDepositZeroETH() public {
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
        // 使用vm.prank模拟用户操作
        vm.prank(user);
        // 预期会触发Deposit事件
        vm.expectEmit(true, true, true, true);
        emit Deposit(user, 1 ether);
        // 调用bank的depositETH方法，发送1个以太币
        bank.depositETH{value: 1 ether}();
    }

    function testRandomUserDeposit() public {
        // 生成随机用户地址
        address randomUser = vm.addr(
            uint256(keccak256(abi.encodePacked("randomUser", block.timestamp)))
        );
        // 给随机用户转账10个以太币
        vm.deal(randomUser, 10 ether);
        // 以随机用户身份调用bank的depositETH方法
        vm.prank(randomUser);
        bank.depositETH{value: 1 ether}();
        // 断言随机用户的余额为1个以太币
        assertEq(bank.balanceOf(randomUser), 1 ether);
    }

    // 测试随机用户存款
    /*
        @notice 测试随机用户存款
        @dev 测试随机用户存款，确保存款金额大于0，用户地址不为零，用户地址有足够的余额进行存款，存款金额不超过用户的余额
        @param t_user 用户地址
        @param amount 存款金额
        @return 无返回值
    */
    function testFuzzRandomUserDeposit(address t_user, uint256 amount) public {
        // 确保用户地址不为零
        vm.assume(t_user != address(0));
        // 确保金额大于0
        vm.assume(amount > 0);
        // 设置用户地址余额为 amount
        // 确保用户地址有足够的余额进行存款
        vm.deal(t_user, amount);
        // 确保金额不超过用户的余额
        vm.assume(amount <= address(t_user).balance);
        // 模拟用户进行存款操作
        vm.prank(t_user);
        bank.depositETH{value: amount}();
        // 验证用户存款后的余额
        assertEq(bank.balanceOf(t_user), amount);
    }

    function test_totalBalance() public view {
        // 获取银行合约的余额
        uint256 totalBankBalance = address(bank).balance;
        // 计算用户余额的总和
        uint256 totalUserBalance = 0;

        // 遍历用户数组，累加每个用户的余额
        for (uint256 i = 0; i < users.length; i++) {
            totalUserBalance += bank.balanceOf(users[i]);
        }

        // 断言银行余额和用户余额的总和相等
        assertEq(totalBankBalance, totalUserBalance);
    }
}
