// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./EcoToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./StakeholderParticipation.sol";

contract ActionVerification {
    address public admin;
    EcoToken public tokenContract;
    StakeholderParticipation public stakeholderContract;

    struct Action {
        address user;
        string ipfsHash;
        bool isVerified;
        uint256 approveCount;
        uint256 disapproveCount;
        address[] voters; // Array of addresses who voted
        mapping(address => bool) voted;
        uint256 startTime; 
    }

    Action[] public actions;

    constructor(address tokenAddress, address stakeholderAddress) {
        admin = msg.sender;
        tokenContract = EcoToken(tokenAddress);
        stakeholderContract = StakeholderParticipation(stakeholderAddress);
    }

    function submitAction(string calldata description) external {
        Action storage action = actions.push();
        action.user = msg.sender;
        action.ipfsHash = description;
        action.isVerified = false;
        action.approveCount = 0;
        action.disapproveCount = 0;
        action.startTime = block.timestamp; 
    }


    function voteAction(uint actionId, bool approve) external {
        require(stakeholderContract.stakes(msg.sender) >= 50, "Insufficient stake to vote");
        Action storage action = actions[actionId];        
        require(msg.sender != action.user, "Cannot vote on your own action"); 
        require(!action.voted[msg.sender], "You have already voted.");
        require(!action.isVerified, "Voting is closed for this action.");


        if (approve) {
            action.approveCount++;
            if (!action.voted[msg.sender]) {  
                action.voters.push(msg.sender); 
            }
        } else {
            action.disapproveCount++;
            if (!action.voted[msg.sender]) {  
                action.voters.push(msg.sender);  
            }
        }
        action.voted[msg.sender] = true;
    }

    function finalizeAction(uint actionId) external {
    Action storage action = actions[actionId];
    require(block.timestamp >= action.startTime + 30 minutes, "Voting period has not yet elapsed.");
    require(!action.isVerified, "Action already finalized.");

    uint256 totalVotes = action.approveCount + action.disapproveCount;
    if (totalVotes == 0) {
        action.isVerified = false; 
        return; // No votes cast, finalize without further processing
    }

    if (action.approveCount * 3 > totalVotes * 2) { 
        // Fixed reward of 2 EcoTokens for each voter
        
        for (uint i = 0; i < action.voters.length; i++) {
            address voter = action.voters[i];
            uint256 rewardVoter = stakeholderContract.stakes(voter)/100;
            require(tokenContract.transfer(voter, rewardVoter), "Failed to transfer reward to voter");
        }
        require(tokenContract.transfer(action.user, 100), "Failed to transfer reward to submitter"); 
        action.isVerified = true; 
    } else {
        stakeholderContract.removeStake(action.user); 
}
}
