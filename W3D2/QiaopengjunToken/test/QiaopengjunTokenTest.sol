// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {QiaopengjunToken} from "../src/QiaopengjunToken.sol";
import {SigUtils} from "../src/SigUtils.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol"; // 导入 ECDSA 用于恢复签名。
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract QiaopengjunTokenTest is Test {
    QiaopengjunToken public token;
    SigUtils internal sigUtils;

    address internal owner;
    address internal spender;

    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");

    uint256 internal ownerPrivateKey;
    uint256 internal spenderPrivateKey;

    function setUp() public {
        ownerPrivateKey = 0xA11CE;
        spenderPrivateKey = 0xB0B;

        owner = vm.addr(ownerPrivateKey);
        spender = vm.addr(spenderPrivateKey);

        // 创建 QiaopengjunToken 合约实例
        token = new QiaopengjunToken(owner);
        sigUtils = new SigUtils(token.DOMAIN_SEPARATOR());

        // Mint some tokens to the owner
        vm.prank(owner);
        token.mint(owner, 1e18);
        assertEq(token.balanceOf(owner), 1e18);
    }

    function testMint() public {
        vm.prank(owner);
        // Mint some tokens to Alice
        token.mint(alice, 100 ether);
        assertEq(token.balanceOf(alice), 100 ether);
    }

    function testMintAndTransfer() public {
        vm.prank(owner);
        // Mint some tokens to Alice
        token.mint(alice, 1000 ether);
        assert(token.balanceOf(alice) == 1000 ether);

        vm.prank(alice);
        // Transfer tokens from Alice to Bob
        token.transfer(bob, 100 ether);
        assert(token.balanceOf(alice) == 900 ether);
        assert(token.balanceOf(bob) == 100 ether);
    }

    function test_Permit() public {
        vm.startPrank(owner);
        SigUtils.Permit memory permit = SigUtils.Permit({
            owner: owner,
            spender: spender,
            value: 1e18,
            nonce: 0,
            deadline: 1 days
        });

        bytes32 digest = sigUtils.getTypedDataHash(permit);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

        token.permit(
            permit.owner,
            permit.spender,
            permit.value,
            permit.deadline,
            v,
            r,
            s
        );

        assertEq(token.allowance(owner, spender), 1e18);
        assertEq(token.nonces(owner), 1);

        vm.stopPrank();
    }
}
