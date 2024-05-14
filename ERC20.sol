// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract Block is IERC20{
    string public name = "Block";
    string public symbol = "BLK";
    uint public decimal = 0;
    address public founder ;
    mapping(address => uint) public balanceOf;

    mapping(address => mapping (address => uint)) public allowed;
    uint public totalSupply;

    constructor(){
        totalSupply = 1000;
        founder = msg.sender;
        balanceOf[founder] = totalSupply;
    }

   //function balanceOf(address account) external view returns (uint256){
   //     return balanceOf[account];
   // }

    function transfer(address to, uint256 value) external returns (bool){
        require(value>0,"value must be greater than 0");
        require(balanceOf[msg.sender]>value,"Balance must be greater than zero");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256){
       return allowed[owner][spender] ;
    }

    //this is like signing a check
    function approve(address spender, uint256 value) external returns (bool){
        require(value>0,"value must be greater than 0");
        require(balanceOf[msg.sender]>value,"Balance must be greater than zero");
        allowed[msg.sender][spender] = value;
        return true;
    }

    // in order to cash out the check
    function transferFrom(address from, address to, uint256 value) external returns (bool){
        require(allowed[from][to] >= value,"Recipient don't have authority to spend ");
        require(balanceOf[from]>value,"Insufficient balance");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        emit Transfer(from, to, value);
        return true;
    }
}// 