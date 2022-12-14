// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// specify the contract name & token details 
contract ERC20FixedSupply{
    address public owner;
    string public name = "Project Token";
    string public symbol = "Ruby";
    uint public totalSupply = 100000000000000000000;
    uint public immutable decimals;
// call events to get current information of smart contract
    event Transfer(address indexed recipient, address indexed to, uint amount);
    event Allowance(address indexed from, address indexed to, uint amount);
// use mapping to store data on the blockchain
    mapping(address => uint) private balance;
    mapping(address => mapping(address => uint)) public allowed;
// call a constructor to specifiy the owner of the tokens
    constructor(){
        owner = msg.sender;
        balance[msg.sender] = totalSupply;
        decimals = 18;
    }
// use a modifier to prevent using the require function
    modifier onlyOwner(){
        require(msg.sender == owner,"You Are Not The Owner");
        _;}
// call function to get the user's balance
        function balanceOf(address user) public view returns(uint){
            return balance[user];
        } 
// call function to transfer balance from the owner's account        
        function transfer(address reciever, uint amount)public returns(bool){
            require(balance[msg.sender] >= amount,"You Do Not Have Enough Tokens");
            balance[msg.sender] -= amount;
            balance[reciever] += amount;
            emit Transfer(msg.sender, reciever, amount);
            return true;
            }
            function allowance(address _owner, address spender) public view returns(uint){
                return allowed[_owner][spender];
            }
            function approval(address spender, uint value) public returns(bool success){
                allowed[msg.sender][spender] = value;
                emit Allowance(msg.sender, spender, value);
                return true;
            }
            function TransferFrom(address from, address to, uint value) public returns(bool success){
                uint allowedTokens = allowed[from][msg.sender];
                require(balance[from] >= value && allowedTokens >= value);
                balance[from] -= value;
                balance[to] += value;
                allowed[from][msg.sender] -= value;
                emit Transfer(from, to, value);
                return true;
                }
    }    
