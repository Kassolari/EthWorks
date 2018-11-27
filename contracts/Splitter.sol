
pragma solidity ^0.4.25;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract TimeConstrainedCounter {

    uint256 public value;
    uint256 public multiple;

    using SafeMath for uint256;
 
    constructor () public {
        value.add(1);
        value.mul(2);
        value.sub(2);
    }    
    
   

}