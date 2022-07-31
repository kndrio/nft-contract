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
        _setTokenURI(
            newItemId,
            "data:application/json;base64,eyJuYW1lIjoiTkZUIGNoaXF1ZSIsCiJkZXNjcmlwdGlvbiI6IlR1YmFpbmFNb3F1ZWNhTWFyYWN1amEiLAoiaW1hZ2UiOiJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJad29nSUhodGJHNXpQU0pvZEhSd09pOHZkM2QzTG5jekxtOXlaeTh5TURBd0wzTjJaeUlLSUNCd2NtVnpaWEoyWlVGemNHVmpkRkpoZEdsdlBTSjRUV2x1V1UxcGJpQnRaV1YwSWdvZ0lIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJZ28rQ2lBZ1BHUmxabk0rQ2lBZ0lDQThiR2x1WldGeVIzSmhaR2xsYm5RZ2FXUTlJa2R5WVdScFpXNTBNU0krQ2lBZ0lDQWdJRHh6ZEc5d0lHTnNZWE56UFNKemRHOXdNU0lnYjJabWMyVjBQU0l3SlNJdlBnb2dJQ0FnSUNBOGMzUnZjQ0JqYkdGemN6MGljM1J2Y0RJaUlHOW1abk5sZEQwaU5UQWxJaTgrQ2lBZ0lDQWdJRHh6ZEc5d0lHTnNZWE56UFNKemRHOXdNeUlnYjJabWMyVjBQU0l4TURBbElpOCtDaUFnSUNBOEwyeHBibVZoY2tkeVlXUnBaVzUwUGdvZ0lEd3ZaR1ZtY3o0S0lDQWdJRHh6ZEhsc1pUNEtJQ0FnSUM1aVlYTmxJSHNLSUNBZ0lDQWdabWxzYkRvZ0kyVmxaVHNLSUNBZ0lDQWdabTl1ZEMxbVlXMXBiSGs2SUhObGNtbG1Pd29nSUNBZ0lDQm1iMjUwTFhOcGVtVTZJREl3Y0hnN0NpQWdJQ0FnSUdOdmJHOXlPaUFqWldWbE93b2dJQ0FnSUNCbWIyNTBMWGRsYVdkb2REcGliMnhrT3dvSklDQjBaWGgwTFhOb1lXUnZkem9nTFRGd2VDQXhjSGdnTW5CNElDTXpNek1zQ2drSkNRa2dJQ0F4Y0hnZ01YQjRJREp3ZUNBak16TXpMQW9KQ1FrSklDQWdNWEI0SUMweGNIZ2dNQ0FqTXpNekxBb0pDUWtKSUNBZ0xURndlQ0F0TVhCNElEQWdJek16TXpzS0lDQWdJSDBLSUNBZ0lDNXpkRzl3TVNCN0lITjBiM0F0WTI5c2IzSTZJR2R5WldWdU95QjlDaUFnSUNBdWMzUnZjRElnZXlCemRHOXdMV052Ykc5eU9pQjNhR2wwWlRzZ2MzUnZjQzF2Y0dGamFYUjVPaUF3T3lCOUNpQWdJQ0F1YzNSdmNETWdleUJ6ZEc5d0xXTnZiRzl5T2lCNVpXeHNiM2M3SUgwS0lDQThMM04wZVd4bFBnb2dJRHh5WldOMElIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SW5WeWJDZ2pSM0poWkdsbGJuUXhLU0lnTHo0S0lDQThkR1Y0ZEFvZ0lDQWdlRDBpTlRBbElnb2dJQ0FnZVQwaU5UQWxJZ29nSUNBZ1kyeGhjM005SW1KaGMyVWlDaUFnSUNCa2IyMXBibUZ1ZEMxaVlYTmxiR2x1WlQwaWJXbGtaR3hsSWdvZ0lDQWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0lLSUNBK0NpQWdJQ0JVZFdKaGFXNWhUVzl4ZFdWallVMWhjbUZqZFdwaENpQWdQQzkwWlhoMFBnbzhMM04yWno0PSIKfQ=="
        );
        console.log("NFT ID %s minted for %s", newItemId, msg.sender);
        //Increment counter for next mint
        _tokenIds.increment();
    }
}
