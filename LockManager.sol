 // SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract LockerTest is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    constructor() ERC721("LockerTestNFT", "LTN") {}

    mapping(uint => string) tokenURIs;

    function _baseURI() internal view override returns (string memory) {
        return "ipfs://";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked(_baseURI(), tokenURIs[tokenId]));
    }

    function mintToken(address owner, string memory metadataCID) public onlyOwner returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _safeMint(owner, newItemId);
        tokenURIs[newItemId] = metadataCID;
        return newItemId;
    }
}