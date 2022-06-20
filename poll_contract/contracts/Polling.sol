// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

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

    struct AddressVoteResponse {
        uint256 pollId;
        uint256 candidateId;
    }

    mapping(uint256 => Candidate[]) public candidates;
    mapping(uint256 => Voter[]) public votes;
    mapping(address => uint256[]) public pollOwners;
    Poll[] public polls;

    function listPolls() public view returns (Poll[] memory allPolls) {
        return polls;
    }

    function listPollCandidates(uint256 index)
        public
        view
        returns (Candidate[] memory pollCandidates)
    {
        return candidates[index];
    }

	function listAddressPolls()
        public
        view
        returns (Poll[] memory addrPolls)
    {
        Poll[] memory myPolls = new Poll[](
            pollOwners[msg.sender].length
        );

		for (uint256 x = 0; x < pollOwners[msg.sender].length; x++) {
			myPolls[x]=polls[pollOwners[msg.sender][x]];
		}

        return myPolls;
    }

    function listAddressVotes()
        public
        view
        returns (AddressVoteResponse[] memory addressVotes)
    {
        uint256 resultCount = 0;
        for (uint256 x = 0; x < polls.length; x++) {
            for (uint256 i = 0; i < votes[x].length; i++) {
                if (votes[x][i].voter == msg.sender) {
                    resultCount++;
                }
            }
        }

        AddressVoteResponse[] memory theVotes = new AddressVoteResponse[](
            resultCount
        );
        for (uint256 x = 0; x < polls.length; x++) {
            for (uint256 i = 0; i < votes[x].length; i++) {
                if (votes[x][i].voter == msg.sender) {
                    theVotes[i] = AddressVoteResponse(
                        x,
                        votes[x][i].candidateId
                    );
                }
            }
        }

        return theVotes;
    }

    function getPollTotalVotes(uint256 pollIndex)
        public
        view
        returns (uint256 count)
    {
        return votes[pollIndex].length;
    }

    function getCandidateTotalVotes(uint256 pollIndex, uint256 candidateIndex)
        public
        view
        returns (uint256 candCount)
    {
        uint256 candVotes = 0;
        for (uint256 i = 0; i < votes[pollIndex].length; i++) {
            if (votes[pollIndex][i].candidateId == candidateIndex) {
                candVotes++;
            }
        }
        return candVotes;
    }

    function createNewPoll(
        string memory title,
        string memory description,
        string memory banner,
        uint256 expiresAt,
        string[] memory candidateTitle,
        string[] memory candidatedDescription,
        string[] memory candidateBanner
    ) public returns (uint256 index) {
        Poll memory poll = Poll(title, description, banner, expiresAt);
        polls.push(poll);
        uint256 pollIndex = polls.length - 1;
        pollOwners[msg.sender].push(pollIndex);

        for (uint256 i = 0; i < candidateTitle.length; i++) {
            Candidate memory candidate = Candidate(
                candidateTitle[i],
                candidatedDescription[i],
                candidateBanner[i]
            );
            candidates[pollIndex].push(candidate);
        }

        return pollIndex;
    }

    function voteForCandidate(uint256 pollIndex, uint256 candidateIndex)
        public
        returns (
            uint256 pollVotes,
            uint256 candidateVotes,
            bool success
        )
    {
        Voter memory vote = Voter(msg.sender, candidateIndex);
        votes[pollIndex].push(vote);
        uint256 candVotes = 0;
        for (uint256 i = 0; i < votes[pollIndex].length; i++) {
            if (votes[pollIndex][i].candidateId == candidateIndex) {
                candVotes++;
            }
        }

        return (votes[pollIndex].length, candVotes, true);
    }
}
