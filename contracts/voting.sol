// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Election {
    address electoralOfficer;

    struct Candidate {
        uint candidateId;
        string candidateName;
        uint noOfVotes;
    }

    Candidate[] public candidatesArray;
    mapping(uint => Candidate) public candidates;
    uint ID;
    uint[] id;
    address[] public voters;
    uint256 startTime;


    constructor () {
        electoralOfficer = msg.sender;
    }

    modifier onlyOwner () {
require(msg.sender == electoralOfficer, "Only electoral officer can add candidates");
        _;
    }


    function addCandidates(string memory _name) public onlyOwner {
        Candidate storage candidate = candidates[ID];
        candidate.candidateId = ID;
        candidate.candidateName = _name;
        candidatesArray.push(candidate);
         uint _id = ID;
        id.push(_id);
        ID++;
    
    }

    function getAllCandidates() public view returns (Candidate[] memory _candidatesArray) {
     uint[] memory all = id;
_candidatesArray = new Candidate[](all.length);

     for(uint i; i < all.length; i++) {
_candidatesArray[i] = candidates[all[i]];
     }

    
    }

    function getCandidate(uint  _id) public view returns (Candidate memory){
        return candidates[_id];
    }

    function startElection () public  {
        require(candidatesArray.length > 1, "Add candidates");
        startTime = block.timestamp;
    }

     function voteCandidate(uint  _id) public {
        require(block.timestamp < startTime + 200  , "Voting over");

         uint votersLength = voters.length;
        bool found = false;
        for(uint i = 0; i< votersLength; i++) {
            require(voters[i] != msg.sender, "You already voted");
            if(voters[i] == msg.sender) {
                 found=true;
                break;
            }
        }
         if(!found){
            voters.push(msg.sender);
        }

        Candidate storage candidate = candidates[_id];

        candidate.noOfVotes++;

     }

     
      function getVoters  () public view  returns (address[] memory) {
         return voters;
     }


    // function declareWinner () view public returns(Candidate memory){

    // }
}