// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Cresento {
    address payable public owner;
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function sendEther(address payable recipient, uint256 amount) public payable {
        require(msg.sender == owner, "Only the owner can send Ether");
        require(address(this).balance >= amount, "Insufficient contract balance");

        balances[recipient] += amount;
        emit Transfer(address(this), recipient, amount);
        recipient.transfer(amount);
    }

    function withdrawEther(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw Ether");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        emit Transfer(msg.sender, address(this), amount);
        owner.transfer(amount);
    }
}