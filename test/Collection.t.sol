//SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import {Collection} from "../src/Collection.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract CollectionTest is Test, ERC721Holder {
    Collection public collection;

    function setUp() public {
	collection = new Collection();
    }

    function testOwner() public {
	assertEq(collection.owner(), address(this));
    }

    function testMint() public {
	string memory tokenURI = "ipfs://abc123";
	vm.startPrank(address(this));
	collection.mint(tokenURI);
	vm.stopPrank();
	assertEq(collection.balanceOf(address(this)), 1);
	assertEq(collection.totalSupply(), 1);
    }

    function testFailMint() public {
	string memory tokenURI = "ipfs://abc123";
	vm.startPrank(address(0xdeadcafe));
	collection.mint(tokenURI);
	vm.stopPrank();
    }

    function testSetTokenURI() public {
	string memory tokenURI = "ipfs://abc123";
	vm.startPrank(address(this));
	collection.mint(tokenURI);
	vm.stopPrank();
	assertEq(collection.tokenURI(0), tokenURI);
    }

    function testFailSetTokenURI() public {
	string memory tokenURI = "ipfs://abc123";
	vm.startPrank(address(0xdeadcafe));
	collection.mint(tokenURI);
	vm.stopPrank();
    }

    function testFailTokenURI_NonexistentToken() public view {
	collection.tokenURI(0);
    }
}
