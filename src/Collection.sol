//SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {IERC721A, ERC721A, ERC721ABurnable} from "erc721a/contracts/extensions/ERC721ABurnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Collection is ERC721ABurnable, Ownable {
    mapping(uint256 => string) private _tokenURIs;
    
    constructor() ERC721A("Personal Profile Picture", "PPP") Ownable(msg.sender) {}

    function mint(string calldata _tokenURI) external onlyOwner {
	uint256 tokenId = _nextTokenId();
	_tokenURIs[tokenId] = _tokenURI;
	_mint(msg.sender, 1);
    }

    function setTokenURI(uint256 tokenId, string calldata _tokenURI) external onlyOwner {
	_tokenURIs[tokenId] = _tokenURI;
    }

    function tokenURI(uint256 tokenId) public view override(IERC721A, ERC721A) returns (string memory) {
	if (!_exists(tokenId)) revert URIQueryForNonexistentToken();
	return _tokenURIs[tokenId];
    }
}
