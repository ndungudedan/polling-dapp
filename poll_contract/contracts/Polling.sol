// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";

contract Polling {
    struct Poll {
        string title;
        string description;
        string banner;
        uint256 expiresAt;
    }

    struct Candidate {
        string title;
        string description;
        string banner;
    }

    struct Voter {
        address voter;
        uint256 candidateId;
    }

    mapping(uint256 => Candidate[]) public candidates;
    mapping(uint256 => Voter[]) public votes;

    Poll[] public polls;

    function listPolls() public view returns (Poll[] memory allPolls) {
        return polls;
    }

    function createNewPoll(
        string memory title,
        string memory description,
        string memory banner,
        uint256 expiresAt
    ) public returns (uint256 index) {
        Poll memory poll = Poll(title, description, banner, expiresAt);
        polls.push(poll);
        return polls.length - 1;
    }

    function createNewCandidate(
        string memory title,
        string memory description,
        string memory banner,
        uint256 index
    ) public {
        Candidate memory candidate = Candidate(title, description, banner);
        candidates[index].push(candidate);
    }
}
