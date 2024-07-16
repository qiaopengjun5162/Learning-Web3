// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./BaseERC20.sol";

// 确保你在调用 deposit 函数之前已经正确调用了 approve 函数，这样才能避免 “ERC20: transfer amount exceeds allowance” 错误。

contract TokenBank {
    // owner：合约部署者即为合约的所有者，拥有撤回资金的权限。
    address public owner;
    // token：要存入的 ERC20 代币合约地址
    BaseERC20 public token;
    // balances：mapping 类型，用于存储每个地址的存款金额。
    mapping(address => uint256) public balances;
    address[3] public topDepositUsers;

    // Deposit 事件，用于记录存款操作
    event Deposit(address indexed user, uint256 amount);
    // Withdraw 事件，用于记录提款操作
    event Withdraw(address indexed user, uint256 amount);

    // 构造函数，设置合约所有者为部署者，并指定 ERC20 代币合约地址
    constructor(address _tokenAddress) {
        owner = msg.sender;
        token = BaseERC20(_tokenAddress);
    }

    // Deposit function
    function deposit(uint256 amount) public {
        require(amount > 0, "Deposit amount must be greater than 0");
        require(
            token.transferFrom(msg.sender, address(this), amount),
            "Token transfer failed"
        );
        balances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);

        // 更新前三名存款用户
        updateTopUsers(msg.sender);
    }

    // Withdraw function
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        require(token.transfer(msg.sender, amount), "Token transfer failed");
        emit Withdraw(msg.sender, amount);
    }

    // Internal function to update top deposit users
    function updateTopUsers(address user) internal {
        uint256 userBalance = balances[user];

        // 检查用户是否已经在前三名中
        for (uint256 i = 0; i < topDepositUsers.length; i++) {
            if (user == topDepositUsers[i]) {
                sortTopUsers();
                return;
            }
        }

        // 如果用户不在前三名且当前存款大于第三名
        if (userBalance > balances[topDepositUsers[2]]) {
            topDepositUsers[2] = user;
            sortTopUsers();
        }
    }

    // Sort the top deposit users
    function sortTopUsers() internal {
        for (uint256 i = 0; i < topDepositUsers.length - 1; i++) {
            for (uint256 j = i + 1; j < topDepositUsers.length; j++) {
                if (
                    balances[topDepositUsers[i]] < balances[topDepositUsers[j]]
                ) {
                    address tempUser = topDepositUsers[i];
                    topDepositUsers[i] = topDepositUsers[j];
                    topDepositUsers[j] = tempUser;
                }
            }
        }
    }

    // View function to get top deposit users and amounts
    function getTopDepositUsers()
        external
        view
        returns (address[3] memory, uint256[3] memory)
    {
        uint256[3] memory topAmounts;
        for (uint256 i = 0; i < topDepositUsers.length; i++) {
            topAmounts[i] = balances[topDepositUsers[i]];
        }
        return (topDepositUsers, topAmounts);
    }

    function permitDeposit(
        address ow,
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        token.permit(ow, address(this), amount, deadline, v, r, s);
        require(
            token.transferFrom(ow, address(this), amount),
            "Transfer failed"
        );
        balances[ow] += amount;
    }

    // Fallback function to receive Ether
    receive() external payable {
        revert("Cannot receive Ether");
    }
}
