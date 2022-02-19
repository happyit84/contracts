 // SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract LockerTest is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    constructor() ERC721("LockerTestNFT6", "LTN2") payable {}

    mapping(uint => string) tokenURIs;

    function _baseURI() internal view override returns (string memory) {
        return "ipfs://";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked(_baseURI(), tokenURIs[tokenId]));
    }

    function mintToken(string memory metadataCID) external payable returns (uint256)
    {
        require(msg.value == 123);

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenURIs[newItemId] = metadataCID;

        return newItemId;
    }

    function getContractBalance() external view returns (uint256)
    {
        return address(this).balance;
    }

    // get ETH balance of the wallet
    function getEthBalance(address wallet) external view returns (uint256)
    {
        return address(wallet).balance;
    }

    function getSenderAddress() external view returns (address)
    {
        return msg.sender;
    }

    function getSenderEthBalance() external view returns (uint256)
    {
        return msg.sender.balance;
    }

    function sendToContract(uint256 numOfEther) external payable
    {
        //payable(this).call{value:numOfEther, gas:1000}("");
    }

    function withdraw() external onlyOwner returns(bool sucess)
    {
        require(msg.sender == owner());
        payable(owner()).transfer(address(this).balance);
        return true;
    }

    receive() external payable {}
    fallback() external payable {}
}