pragma solidity ^0.4.13;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

struct Proposal {
  uint256 public id;
  address public beneficiary;
  string public name;
  bytes32 public productHash;
  uint256 public votes;
  uint public deadline;
  mapping (address => bool) voted;
}

modifier onlyMembers {
      require(balances[msg.sender] > 0);
      _;
}

contract ForsetiCoin is MintableToken {
  string public name = "FORSETI COIN";
  string public symbol = "FRS";
  uint8 public decimals = 18;
  mapping (bytes32 => string) storedProduct;
  Proposal[] public proposals;
  uint public daysDeadline = 10;
  uint public votesToBelieve = 30;

  function makeProposalForDocumentIdentity(uint id, bytes32 docHash, string name) returns (uint proposalId) onlyMembers {
    proposalId = proposals.length++;
    Proposal storage p = proposals[proposalId];
    p.name = name;
    p.deadline = now + daysDeadline * 1 days;
    p.docHash = docHash;
    balances[msg.sender]--;

    }

    function vote (uint proposalId,bytes32 docHash) onlyMembers {

      Proposal storage p = proposals[proposalId];
      require (!p.voted[msg.sender]);
      require (docHash == p.docHash);
      require (p.deadline >= now + deadlineDays);
      p.voted[msg.sender] = true;
      p.votes++;

      if (p.votes >= votesToBelieve)
      {
        storedProduct[docHash] = p.name;
      }
    }

    function verifyDocument(uint id, bytes32 docHash, string name) returns (bool verified){
        bool verified;

        if (storedProduct[docHash] == name)
        {
          verified = true;
        }
        else
        {
          verified = false;
        }
     }
}
