
pragma solidity ^0.4.25;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

//For help to get familiar with ERC20 token functions
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

    ERC20 public token;
    uint256 public equalAmount;
    address public owner;
    address public feeCollector;
    address[] public beneficiaries;
    
    using SafeMath for uint256;

    //Mods

    modifier onlyOwner(){
        require(msg.sender == owner,"You are not owner of funds");
        _;
    }

    constructor(address[] _beneficiaries, address _feeCollector, ERC20 _token) public {
        require(_beneficiaries.length > 1,"Too few addresses to divide funds");

        owner = msg.sender;
        beneficiaries = _beneficiaries;
        feeCollector = _feeCollector;
        token = _token;
    }

    function calculateAmount(uint256 _amount) private view returns (uint256){
        if (_amount.sub(1) % beneficiaries.length == 0  ) {return (_amount.sub(1)).div(beneficiaries.length);}
        else { 
            return (((_amount.sub(1)).sub((_amount.sub(1) % beneficiaries.length))).div(beneficiaries.length));
        } 
    }

    function split (uint256 amount) public {
        require(amount > beneficiaries.length,"Amount is to small to divide");
        require(token.balanceOf(msg.sender) > amount,"Your balance is to small");
        require(address(this).balance > 0,"No gas to run contract");

        token.approve(msg.sender,amount);
        equalAmount = calculateAmount(amount);
        for (uint32 i = 0; i < beneficiaries.length; ++i) {
            token.transferFrom(msg.sender,beneficiaries[i],equalAmount);
        }
        token.transferFrom(msg.sender,feeCollector,1);
    }

    function withdraw(address beneficiary) public payable onlyOwner {
        beneficiary.transfer(address(this).balance);
    }
}