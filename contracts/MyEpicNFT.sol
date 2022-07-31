// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Hooray!");
    }

    function makeAnEpicNFT() public {
        //get actual tokenId, start with 0
        uint256 newItemId = _tokenIds.current();

        //Mint NFT to the sender who activated the contract
        _safeMint(msg.sender, newItemId);
        //Designate NFT data
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/1Z4U");
        console.log("NFT ID %s minted for %s", newItemId, msg.sender);
        //Increment counter for next mint
        _tokenIds.increment();
    }
}
