pragma solidity ^0.4.13;

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract ForsetiCoin is MintableToken {
  string public name = "FORSETI COIN";
  string public symbol = "FRS";
  uint8 public decimals = 18;
}
