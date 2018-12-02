pragma solidity ^0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract BasicTokenMock is BasicToken1 {

  constructor(address initialAccount, uint256 initialBalance) public {
    balances[initialAccount] = initialBalance;
    totalSupply_ = initialBalance;
  }

}