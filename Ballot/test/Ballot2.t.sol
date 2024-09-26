// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Ballot2} from "../src/Ballot2.sol";

contract Ballot2Test is Test {
    Ballot2 public ballot;
    address chairperson;
    address voter1;
    address voter2;
    bytes32[] proposalNames;

    function setUp() public {
        chairperson = address(this);
        voter1 = address(0x1);
        voter2 = address(0x2);
        proposalNames = new bytes32[](2);
        proposalNames[0] = "Proposal 1";
        proposalNames[1] = "Proposal 2";

        // 设置当前时间为 1000，并构造一个 60 秒的投票窗口
        vm.warp(1000);
        ballot = new Ballot2(block.timestamp + 10, block.timestamp + 60, proposalNames);
    }

    function testConstructorInitialization() public view {
        assertEq(ballot.startTime(), block.timestamp + 10);
        assertEq(ballot.endTime(), block.timestamp + 60);
        assertEq(ballot.chairperson(), chairperson);
        // 解构元组，提取提案的 name 和 voteCount 字段
        (bytes32 name1,) = ballot.proposals(0); // 获取第一个提案的 name
        (bytes32 name2,) = ballot.proposals(1); // 获取第二个提案的 name

        // 检查提案的名称
        assertEq(name1, "Proposal 1");
        assertEq(name2, "Proposal 2");
    }

    function testGiveRightToVote() public {
        ballot.giveRightToVote(voter1);
        (uint256 weight, bool voted,,) = ballot.voters(voter1);
        assertEq(weight, 1);
        assertFalse(voted);
    }

    function testCannotVoteBeforeVotingPeriod() public {
        ballot.giveRightToVote(voter1);
        vm.warp(1005); // 在投票开始前投票
        vm.prank(voter1);
        vm.expectRevert("Voting is not in progress");
        ballot.vote(0);
    }

    function testCanVoteDuringVotingPeriod() public {
        ballot.giveRightToVote(voter1);
        vm.warp(1011); // 投票窗口内
        vm.prank(voter1);
        ballot.vote(0);
        (uint256 weight, bool voted,,) = ballot.voters(voter1);
        assertTrue(voted);
        (, uint256 voteCount) = ballot.proposals(0);
        assertEq(voteCount, 1);
        assertEq(weight, 1);
    }

    function testCannotVoteAfterVotingPeriod() public {
        ballot.giveRightToVote(voter1);
        vm.warp(1061); // 投票结束后
        vm.prank(voter1);
        vm.expectRevert("Voting is not in progress");
        ballot.vote(0);
    }

    function testDelegateVote() public {
        ballot.giveRightToVote(voter1);
        ballot.giveRightToVote(voter2);

        // voter1 委托 voter2
        vm.prank(voter1);
        ballot.delegate(voter2);

        (uint256 weight1, bool voted1,,) = ballot.voters(voter1);
        assertTrue(voted1);
        assertEq(weight1, 1);

        (uint256 weight2, bool voted2,,) = ballot.voters(voter2);
        assertEq(weight2, 2);
        assertFalse(voted2);
    }

    function testWinningProposal() public {
        ballot.giveRightToVote(voter1);
        ballot.giveRightToVote(voter2);
        // 设置投票权重
        vm.warp(1010);
        ballot.setVoterWeight(voter1, 2);
        ballot.setVoterWeight(voter2, 3);

        // 在投票期内投票
        vm.warp(1011);
        vm.prank(voter1);
        ballot.vote(0);
        vm.prank(voter2);
        ballot.vote(1);

        // voter2 赢得投票
        assertEq(ballot.winningProposal(), 1);
        assertEq(ballot.winnerName(), "Proposal 2");
    }

    function testSetVoterWeight() public {
        vm.warp(1011); // 确保在投票期间调用
        ballot.setVoterWeight(voter1, 3);

        (uint256 weight,,,) = ballot.voters(voter1);
        assertEq(weight, 3);
    }

    function testCannotSetVoterWeightBeforeVotingPeriod() public {
        vm.expectRevert("Voting is not in progress");
        ballot.setVoterWeight(voter1, 3);
    }

    function testCannotSetVoterWeightIfNotOwner() public {
        vm.warp(1011); // 投票期内
        vm.prank(voter1);
        vm.expectRevert("Only the chairperson can call this function");
        ballot.setVoterWeight(voter2, 3);
    }
}
