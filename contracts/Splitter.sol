
pragma solidity ^0.4.25;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

/*contract ERC20 {
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (uint balance);
    function allowance(address tokenOwner, address spender) public constant returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}*/

contract Splitter {

    ERC20 token;
    uint256 public value;
    address owner;
    address feeCollector;
    address[] beneficiaries;
    
    using SafeMath for uint256;

    // Mods
    modifier onlyOwner(){
        require(owner == msg.sender,"executed only by owner");
        _;
    }

    constructor(address[] _beneficiaries, address _feeCollector, ERC20 _token) public {
        owner = msg.sender;
        beneficiaries = _beneficiaries;
        feeCollector = _feeCollector;
        token = _token;

    }    

    function split (uint256 amount) public onlyOwner {
        
    }

}