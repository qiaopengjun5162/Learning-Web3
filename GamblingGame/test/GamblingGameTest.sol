// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

import {GamblingGame} from "../src/GamblingGame.sol";

contract TestERC20 is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract GamblingGameTest is Test {
    using SafeERC20 for IERC20;

    GamblingGame public gamblinggame;
    ERC1967Proxy proxy;

    TestERC20 public token;
    address public initialOwner = msg.sender;
    address public luckyDrawer = msg.sender;
    uint256 public gameBlock = 32;

    function setUp() public {
        token = new TestERC20("Test Token", "TT");
        token.mint(address(this), 1000);

        GamblingGame implementation = new GamblingGame();

        // gamblinggame = new GamblingGame();
        // gamblinggame.initialize(initialOwner, address(token), luckyDrawer, gameBlock);
        proxy = new ERC1967Proxy(
            address(implementation),
            abi.encodeCall(implementation.initialize, (initialOwner, address(token), luckyDrawer, gameBlock))
        );
        // 用代理关联 MyToken 接口
        gamblinggame = GamblingGame(address(proxy));

        vm.stopPrank();
    }

    function testTokenBalance() public view {
        assertEq(token.balanceOf(address(this)), 1000);
    }
}
