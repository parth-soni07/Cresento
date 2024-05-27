// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// import "./ERC720.sol";

contract Cresento {
    mapping (string => mapping (string => bool) ) txnPairs;
    mapping (string => uint256) balances;

    event Transfer(string indexed username, string indexed receiver, uint64 amount);

    constructor() {
        
    }
    function addTxnPairs(string memory user1, string memory user2) public {
        txnPairs[user1][user2] = true;
        txnPairs[user2][user1] = true;
    }

    function transfer(string memory un, string memory rec, uint64 amt, string memory authorizedUser) public {
        require(txnPairs[un][authorizedUser], "Unauthorized Transfer");
        require(balances[un] >= amt, "Insuffecient Balance");

        balances[un] -= amt;
        balances[rec] += amt;
        
    }

}