// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract WrappedEther is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    constructor(
        address initialOwner
    )
        ERC20("Wrapped Ether", "WETH")
        Ownable(initialOwner)
        ERC20Permit("Wrapped Ether")
    {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Deposit function: Wrap ETH into WETH
    function deposit() public payable {
        require(msg.value > 0, "Must send ETH to wrap");
        _mint(msg.sender, msg.value); // Mint WETH equal to the amount of ETH sent
    }

    // Withdraw function: Unwrap WETH back into ETH
    function withdraw(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient WETH balance");
        _burn(msg.sender, amount); // Burn the equivalent amount of WETH
        payable(msg.sender).transfer(amount); // Send the unwrapped ETH back to the sender
    }

    // Fallback function to handle receiving ETH
    receive() external payable {
        deposit();
    }
}
