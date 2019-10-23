pragma solidity ^0.5.11;

contract CrowdFunder {
    //Variable set by Onwer of this contract
    address payable public owner;
    uint256 public minimalToRaise;
    uint256 public expiredDay;
    
    constructor(address payable _owner, uint256 _minimalToRaise, uint256 _timeInHoursForRaising) public{
        owner = _owner;
        minimalToRaise = _minimalToRaise;
        expiredDay = block.timestamp + (_timeInHoursForRaising * 1 hours);
    }
}