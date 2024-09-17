// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./interfaces/IGamblingGame.sol";

contract GamblingGame is Initializable, OwnableUpgradeable, ReentrancyGuardUpgradeable, IGamblingGame {
    using SafeERC20 for IERC20;

    enum BettorType {
        Big,
        Small,
        Single,
        Double
    }

    IERC20 public betteToken;
    uint256 public betteTokenDecimal;
    uint256 public gameBlock;
    uint256 public hgmGlobalId;
    address public luckyDrawer;

    struct RoundGame {
        uint256 startBlock;
        uint256 endBlock;
        uint256[2] threeNumbers;
    }

    struct GuessBettor {
        address account;
        uint256 value;
        uint8 betType;
        bool isReward;
        bool hasReward;
        uint256 rewardValue;
    }

    GuessBettor[] public guessBettorList;

    mapping(uint256 => RoundGame) public roundGameInfo;
    mapping(uint256 => mapping(address => GuessBettor)) public gussBettorMapping;

    event GuessBettorCreate(address indexed account, uint256 value, uint8 betType);
    event AllocateReward(address indexed account, uint256 hgmId, uint8 betType, bool hasReward, uint256 rewardValue);

    modifier onlyLuckyDrawer() {
        require(luckyDrawer == msg.sender, "onlyLuckyDrawer: caller must be a lucky drawer");
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _initialOwner, address _betteToken, address _luckyDrawer, uint256 _gameBlock)
        public
        initializer
    {
        __Ownable_init(_initialOwner);
        betteToken = IERC20(_betteToken);
        luckyDrawer = _luckyDrawer;
        gameBlock = _gameBlock;
        hgmGlobalId = 1;
        betteTokenDecimal = 18;
        uint256[2] memory fixedAarray;
        roundGameInfo[hgmGlobalId] = RoundGame(block.number, (block.number + _gameBlock), fixedAarray);
    }

    function setBetteToken(address tokenAddress, uint256 tokenDecimal) external onlyOwner {
        betteToken = IERC20(tokenAddress);
        betteTokenDecimal = tokenDecimal;
    }

    function setGameBlock(uint256 gameBlockNumber) external onlyOwner {
        gameBlock = gameBlockNumber;
    }

    function getBalance() external view returns (uint256) {
        return betteToken.balanceOf(address(this));
    }

    function createBettor(uint256 betAmount, uint8 betTypeItem) external returns (bool) {
        require(
            betTypeItem >= uint8(BettorType.Big) && betTypeItem <= uint8(BettorType.Double),
            "createBettor: invalid bette type"
        );
        require(
            betAmount >= 10 ** betteTokenDecimal,
            "createBettor: bette amount must be greater than 10 ** betteTokenDecimal"
        );
        require(betteToken.balanceOf(msg.sender) >= betAmount, "createBettor: insufficient balance");
        require(roundGameInfo[hgmGlobalId].endBlock >= block.number, "createBettor: game has ended");

        betteToken.safeTransferFrom(msg.sender, address(this), betAmount);

        GuessBettor memory gb = GuessBettor({
            account: msg.sender,
            value: betAmount,
            betType: betTypeItem,
            isReward: false,
            hasReward: false,
            rewardValue: 0
        });

        guessBettorList.push(gb);

        emit GuessBettorCreate(msg.sender, betAmount, betTypeItem);

        return true;
    }

    function luckyDraw(uint256[2] memory threeNumbersFrom) external onlyLuckyDrawer returns (bool) {
        require(block.number > roundGameInfo[hgmGlobalId].endBlock, "luckyDraw: The game has not ended yet");

        uint256 threeNumberResult = 0;
        for (uint256 i = 0; i < threeNumbersFrom.length; i++) {
            threeNumberResult += threeNumbersFrom[i];
        }

        require(threeNumberResult >= 25, "luckyDraw: The sum of the three numbers must be greater than 25");

        for (uint256 i = 0; i < guessBettorList.length; i++) {
            if (
                (threeNumberResult >= 14 && threeNumberResult <= 27)
                    && (guessBettorList[i].betType == uint8(BettorType.Big))
            ) {
                uint256 rewardValue = guessBettorList[i].value * 150 / 100;
                allocateReward(guessBettorList[i], rewardValue);
            }

            if (
                (threeNumberResult >= 0 && threeNumberResult <= 13)
                    && (guessBettorList[i].betType == uint8(BettorType.Small))
            ) {
                uint256 rewardValue = guessBettorList[i].value * 200 / 100;
                allocateReward(guessBettorList[i], rewardValue);
            }

            if ((threeNumberResult % 2 == 0) && (guessBettorList[i].betType == uint8(BettorType.Double))) {
                uint256 rewardValue = guessBettorList[i].value * 400 / 100;
                allocateReward(guessBettorList[i], rewardValue);
            }

            if ((threeNumberResult % 2 != 0) && (guessBettorList[i].betType == uint8(BettorType.Single))) {
                uint256 rewardValue = guessBettorList[i].value * 200 / 100;
                allocateReward(guessBettorList[i], rewardValue);
            }

            allocateReward(guessBettorList[i], 0);
        }
        delete guessBettorList;

        uint256[2] memory fixedAarray;
        roundGameInfo[hgmGlobalId++] = RoundGame(block.number, (block.number + gameBlock), fixedAarray);

        return true;
    }

    function allocateReward(GuessBettor memory guessBettor, uint256 rewardAmount) internal {
        if (rewardAmount > 0) {
            guessBettor.isReward = true;
            guessBettor.rewardValue = rewardAmount;

            betteToken.safeTransfer(guessBettor.account, rewardAmount);
            guessBettor.hasReward = true;
        }

        gussBettorMapping[hgmGlobalId][guessBettor.account] = guessBettor;

        emit AllocateReward(guessBettor.account, hgmGlobalId, guessBettor.betType, guessBettor.hasReward, rewardAmount);
    }
}
