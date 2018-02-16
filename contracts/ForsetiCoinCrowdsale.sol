pragma solidity ^0.4.13;

import './ForsetiCoin.sol';
import 'zeppelin-solidity/contracts/crowdsale/Crowdsale.sol';


contract ForsetiCoinCrowdsale is Crowdsale {

  mapping(address => bool) members;
  uint private softcapMembers;
  uint private membersCount;
  function ForsetiCoinCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, uint256 _softcapMembers, address _wallet)
    Crowdsale(_startTime, _endTime, _rate, _wallet) {
      softcapMembers = _softcapMembers;
  }

  // creates the token to be sold.
  // override this method to have crowdsale of a specific MintableToken token.
  function createTokenContract() internal returns (MintableToken) {
    return new ForsetiCoin();
  }

  function refund() {
    require(this.membersCount < this.softcapMembers && now > endTime);
    uint value = balances[msg.sender];
    balances[msg.sender] = 0;
    msg.sender.transfer(value);
  }

  function () external payable {
   if (!members[msg.sender])
   {
     membersCount++;
     members[msg.sender]=true;
   }
   buyTokens(msg.sender);
 }
}
