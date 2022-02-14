 // SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract LockerTest is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    constructor() ERC721("LockerTestNFT4", "LTN2") {}

    mapping(uint => string) tokenURIs;

    function _baseURI() internal view override returns (string memory) {
        return "ipfs://";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked(_baseURI(), tokenURIs[tokenId]));
    }

    function mintToken(string memory metadataCID) public returns (uint256)
    {
        require(address(msg.sender).balance > 0.001 ether);

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenURIs[newItemId] = metadataCID;
        //safeTransferFrom(owner(), to, newItemId, "");
        //address payable ownerPayable = payable(owner());
        
        //ownerPayable.transfer(0.001 ether);

        return newItemId;
    }

    // get ETH balance of the wallet
    function getEthBalance(address wallet) public view returns (uint256)
    {
        return address(wallet).balance;
    }
}