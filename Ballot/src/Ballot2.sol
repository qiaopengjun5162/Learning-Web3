// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 为投票过程添加时间限制。设置一个开始时间和结束时间来控制投票的时间窗口。用户只能在投票周期内进行投票。
// 在合约中添加两个新的状态变量 startTime 和 endTime，用于表示投票的开始时间和结束时间。
// 在构造函数中初始化这些时间变量。
// 修改 vote 函数，确保用户只能在时间窗口内投票。如果不在时间窗口内投票，应该抛出错误。
contract Ballot2 {
    uint256 public startTime;
    uint256 public endTime;

    struct Voter {
        uint256 weight;
        bool voted;
        address delegate;
        uint256 vote;
    }

    struct Proposal {
        bytes32 name;
        uint256 voteCount;
    }

    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    modifier onlyDuringVoting() {
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Voting is not in progress");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == chairperson, "Only the chairperson can call this function");
        _;
    }

    constructor(uint256 _startTime, uint256 _endTime, bytes32[] memory proposalNames) {
        require(_startTime >= block.timestamp, "startTime must be in the future");
        require(_endTime >= _startTime, "endTime must be greater than startTime");

        startTime = _startTime;
        endTime = _endTime;

        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function giveRightToVote(address voter) external {
        require(msg.sender == chairperson, "Only chairperson can give right to vote.");
        require(!voters[voter].voted, "The voter already voted.");
        require(voters[voter].weight == 0, "The voter already has voting rights.");

        voters[voter].weight = 1;
    }

    function delegate(address to) external {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You have no right to vote.");
        require(!sender.voted, "You already voted.");
        require(to != msg.sender, "Self-delegation is disallowed.");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;

            require(to != msg.sender, "Found loop in delegation.");
        }

        Voter storage delegate_ = voters[to];
        require(delegate_.weight >= 1, "Selected delegate does not have voting rights.");
        sender.voted = true;
        sender.delegate = to;
        if (delegate_.voted) {
            proposals[delegate_.vote].voteCount += sender.weight;
        } else {
            delegate_.weight += sender.weight;
        }
    }

    function vote(uint256 proposal) external onlyDuringVoting {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "Has no right to vote.");
        require(!sender.voted, "Already voted.");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint256 winningProposal_) {
        uint256 winningVoteCount = 0;
        for (uint256 p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }

    function winnerName() external view returns (bytes32 winnerName_) {
        winnerName_ = proposals[winningProposal()].name;
    }

    // 允许投票权重的设置。投票权重可以由合约所有者设置，默认每个选民的权重为1。
    // 允许合约所有者为某个选民设置特定的投票权重，并添加时间限制。
    // 确保只有合约所有者（chairperson）可以调用此函数。
    function setVoterWeight(address voter, uint256 weight) external onlyDuringVoting onlyOwner {
        require(weight > 0, "Weight must be greater than 0.");

        Voter storage v = voters[voter];
        v.weight = weight;
    }
}
