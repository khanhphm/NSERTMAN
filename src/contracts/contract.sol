// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@5.0.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@5.0.0/token/ERC721/extensions/ERC721URIStorage.sol";

contract SERT is ERC721, ERC721URIStorage {
    address Owner;
    mapping(address => bool) isManager;

    constructor() ERC721("Certificate Manager", "SERT") {
        Owner = msg.sender;
        isManager[Owner] = true;
    }

    modifier onlyOwner() {
        require(
            msg.sender == Owner,
            "You dont have permission!! You must be the owner"
        );
        _;
    }
    modifier onlyManager() {
        require(
            isManager[msg.sender] == true,
            "You dont have permission!! You must be a manager"
        );
        _;
    }

    function setManagerStatus(address _address, bool status) public onlyOwner {
        require(!isManager[_address], "Address must be not Owner");
        isManager[_address] = status;
    }

    uint public _tokenId = 0;
    mapping(address => uint[]) public tokenIdsByAddress;

    function safeMint(address to, string memory uri) public onlyManager {
        _safeMint(to, _tokenId);
        _setTokenURI(_tokenId, uri);
        tokenIdsByAddress[to].push(_tokenId);
        _tokenId++;
    }

    function getTokensByAddress(
        address _address
    ) public view returns (uint[] memory) {
        return tokenIdsByAddress[_address];
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
