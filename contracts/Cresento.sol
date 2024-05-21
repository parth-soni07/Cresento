// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CresentoWallet is ERC721URIStorage, Ownable{
    string public username;
    address public userAddress;
    uint64 public tokenAmount;
    address payable recepientAddress;
    bool public signedIn =  false;
    
    event TransferSuccessful(address payable recepientAddress, uint64 tokenAmount);

    mapping (string => bool) wallet;
    // This is the function to mint the tokens, the minted tokens will be then used to be transferred
    function mintToken (address _to, uint64 _tokenAmount, string calldata _uri) external onlyOwner {
        _mint(_to,_tokenAmount);
        _setTokenURI(_tokenAmount, _uri);
    }
    // Create Wallet Button will be used to create an account using the username & entered password.
    function createWallet(string memory username, string memory password) public {
        require(!wallet[username], "Username Exists");
        wallet[username] = true;
    }
    // for login and stuff, I dont think the blockchain will be responsible to take care of, js will handle it, only the username will be sent to the backend
    constructor (string memory _username , address _userAddress, uint64 _tokenAmount, address payable _recepientAddress) ERC721 ("CresentoToken", "CTEA") Ownable (msg.sender){
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(_recepientAddress != address(0), "Recipient address cannot be empty");
        require(_userAddress != address(0), "Recipient address cannot be empty");
        require(tokenAmount > 0, "You cannot send 0 to Recepient");
        username = _username;
        userAddress = _userAddress;
        tokenAmount = _tokenAmount;
        recepientAddress = _recepientAddress;
    }
    // Transfer will be responsible for the transfer of the money
    function transfer() public payable {
        require(msg.value >= tokenAmount, "Insuffecient token to complete the transaction");
        // ERC721 token = ERC721()
    }
    // basically the logic behind these contracts is simple, you just have one main function and all the functions call 
    // themselves in a chainical order so that all the work is done, so the function that is called sabse pehele is constructor
    // 
    function transferToken () public payable {
        require(msg.value >= tokenAmount, "Insuffecient token to complete the transaction");
        recepientAddress.transfer(tokenAmount);
        emit TransferSuccessful(recepientAddress, tokenAmount);
    }
}
