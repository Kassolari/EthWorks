pragma solidity ^0.4.25;

contract Escrow {

    uint256 public price;
  
    address public seller;
    address public buyer;
      
    bool public isCreated;
    bool public isResolved;
    bool public isInProgress;
    
    bool public isSend;
    bool public isRecieved;

    //function modifications

    modifier onlySeller(){
        require(seller == msg.sender,"Can be executed only by the creator of contract");
        _;
    }

    modifier onlyBuyer(){
        require(buyer == msg.sender,"Can be executed only by the buyer");
        _;
    }

    constructor() public payable {
        // the seller creates a Smart Contract
        
        require(msg.value % 2 == 0 && msg.value != 0,"Checks if correct amount is deposited by seller");
        
        price = msg.value/2;
        seller = msg.sender;
        isCreated = true;
        isResolved = false;
        isInProgress = false;
        isSend = false;
        isRecieved = false;
      
    }

    function cancel() public onlySeller {
        // the seller cancels created Smart Contract
        require(isCreated == true && isResolved == false && isInProgress == false,"Wrong state, transaction is in progress");
        selfdestruct(seller);
    }

    function confirmPurchase() public payable {
        require(msg.value == price*2,"Buyer paid wrong ammount for the item/service");
        require(address(this).balance + price*2 >= address(this).balance,"Overflow of the contract balance");
        require(isCreated == true && isResolved == false && isInProgress == false,"Wrong state, transaction is already in progress");

        buyer = msg.sender;
        isCreated = false;
        isInProgress = true;
        isResolved = false;
        isSend = true;
    }

    function confirmReceived() public onlyBuyer {
        // the buyer confirms goods received
        isRecieved = true;
        isCreated = false;
        isInProgress = false;
        isResolved = true;
        seller.transfer(3*price);
        buyer.transfer(price);

    }
}