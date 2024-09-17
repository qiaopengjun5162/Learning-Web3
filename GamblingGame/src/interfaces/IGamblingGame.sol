// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IGamblingGame {
    function setBetteToken(address tokenAddress, uint256 tokenDecimal) external;

    function setGameBlock(uint256 gameBlockNumber) external;

    function getBalance() external view returns (uint256);

    function createBettor(uint256 betAmount, uint8 betTypeItem) external returns (bool);

    function luckyDraw(uint256[2] memory threeNumbersFrom) external returns (bool);
}
