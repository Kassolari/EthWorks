
pragma solidity ^0.4.25;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Splitter {

    uint256 public value;
    
    using SafeMath for uint256;
 
    constructor(address[] beneficiaries, address feeCollector, ERC20 token) public {
        
    }    

    function split (uint256 amount) public {
        
    }

}