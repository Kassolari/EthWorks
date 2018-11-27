
pragma solidity ^0.4.25;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Splitter {

    ERC20 token;
    uint256 public value;
    address owner;
    address feeCollector;
    
    using SafeMath for uint256;

    // Mods
    modifier onlyOwner(){
        require(owner == msg.sender,"executed only by owner");
        _;
    }

    constructor(address[] beneficiaries, address feeCollector, ERC20 _token) public {
        owner = msg.sender;

    }    

    function split (uint256 amount) public onlyOwner {
        
    }

}