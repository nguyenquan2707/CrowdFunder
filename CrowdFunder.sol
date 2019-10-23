pragma solidity ^0.5.11;

contract CrowdFunder {
    //Variable set by Onwer of this contract
    address payable public owner;
    uint256 public minimalToRaise;
    uint256 public expiredDay;
    
    event logContribute(uint256 amount, address contributor, uint256 totalRaise);
    
    uint256 totalRaise;
    
    State public state = State.FunRaising; 
    
    Contribution[] contributions;
    
    constructor(address payable _owner, uint256 _minimalToRaise, uint256 _timeInHoursForRaising) public{
        owner = _owner;
        minimalToRaise = _minimalToRaise;
        expiredDay = block.timestamp + (_timeInHoursForRaising * 1 hours);
    }
    
    // Contribution struct
    struct Contribution {
        uint256 amount;
        address payable contributor;
    }
    
    enum State { FunRaising, ExpiredRefund, Successful }
    
    function contrubite() public payable returns(uint256) {
        require(state == State.FunRaising);
        contributions.push( Contribution({ amount: msg.value, contributor: msg.sender }));
        totalRaise += msg.value;
        
        emit logContribute(msg.value, msg.sender, totalRaise);
        
        if(totalRaise >= minimalToRaise) {
            state = State.Successful;
            owner.transfer(totalRaise); // transfer total fund to who he/she deploy this contract
        } else if (block.timestamp > expiredDay) {
            state = State.ExpiredRefund;
        }
    }
}