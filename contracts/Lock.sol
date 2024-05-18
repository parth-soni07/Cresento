// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract CresentoWallet is ERC721{
    string username;
    address userAddress;
    uint64 tokenAmount;
    address recepientAddress;

    mapping (string => bool) wallet;
    function createWallet(string memory username, string memory password) public {
        require(!wallet[username], "Username Exists");
        wallet[username] = true;
    }

    constructor (string memory _username , address _userAddress, uint64 _tokenAmount, address _recepientAddress) ERC721 ("CresentoToken", "CTEA"){
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(_recepientAddress != address(0), "Recipient address cannot be empty");
        require(_userAddress != address(0), "Recipient address cannot be empty");
        require(tokenAmount > 0, "You cannot send 0 to Recepient");

        username = _username;
        userAddress = _userAddress;
        tokenAmount = _tokenAmount;
        recepientAddress = _recepientAddress;
    }

}
