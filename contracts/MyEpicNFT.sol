// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg =
        "<svg  xmlns='http://www.w3.org/2000/svg'  preserveAspectRatio='xMinYMin meet'  viewBox='0 0 350 350'>  <defs>    <linearGradient id='Gradient1'>      <stop class='stop1' offset='0%'/>      <stop class='stop2' offset='50%'/>      <stop class='stop3' offset='100%'/>    </linearGradient>  </defs>    <style>    .base {      fill: #eee;      font-family: serif;      font-size: 20px;      color: #eee;      font-weight:bold;   text-shadow: -1px 1px 2px #333,       1px 1px 2px #333,       1px -1px 0 #333,       -1px -1px 0 #333;    }    .stop1 { stop-color: green; }    .stop2 { stop-color: white; stop-opacity: 0; }    .stop3 { stop-color: yellow; }  </style>  <rect width='100%' height='100%' fill='url(#Gradient1)' />  <text    x='50%'    y='40%'    class='base'    dominant-baseline='middle'    text-anchor='middle'  >";
    string[] firstWords = [
        "Eu matei ",
        "Joguei pedra no(a) ",
        "Eu comi ",
        "Dei uma voadora ",
        "Eu maltratei ",
        "Ganhei no par ou impar de ",
        "Eu beijei ",
        "Eu vomitei um ",
        "Fiz sexo com ",
        "Consolei ",
        "Chamei pra sair ",
        "Destrocei "
    ];
    string[] secondWords = [
        "meu ursinho de pelucia ",
        "Bob marley ",
        "uma pedra ",
        "o lula ",
        "o bolsonaro ",
        "uma colher ",
        "o mendigo ",
        "a loira do banheiro ",
        "um sabonete ",
        "uma barbie ",
        "a privada da rodoviaria "
    ];
    string[] thirdWords = [
        "pq estava drogado.",
        "nao lembro o porque.",
        "pq ele nao tem o mindinho.",
        "o Queiros mandou.",
        "pq nao consigo me controlar.",
        "pq me ofereceram um real.",
        "pq estava calor e eu estava nervoso.",
        "o STF me deu habeas corpus.",
        "pq perdi o chinelo."
        "pq sou ousado."
    ];

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Hooray!");
    }

    // Random word from list.
    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // seed for "random" generator.
        uint256 rand = random(
            string(
                abi.encodePacked("PRIMEIRA_PALAVRA", Strings.toString(tokenId))
            )
        );
        // Max number from list.
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(
                abi.encodePacked("SEGUNDA_PALAVRA", Strings.toString(tokenId))
            )
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(
                abi.encodePacked("TERCEIRA_PALAVRA", Strings.toString(tokenId))
            )
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        //get actual tokenId, start with 0
        uint256 newItemId = _tokenIds.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );
        string memory combinedWordSvg = string(
            abi.encodePacked(
                "<tspan x='50%' dy='1em'>",
                first,
                "</tspan><tspan x='50%' dy='1em'>",
                second,
                "</tspan><tspan x='50%' dy='1em'>",
                third,
                "</tspan>"
            )
        );

        //Closing SVG
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, combinedWordSvg, "</text></svg>")
        );

        //Encoding json to base64.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        //NFT title with combinedWord
                        combinedWord,
                        '", "description": "Uma colecao divertida de NFTs.", "image": "data:image/svg+xml;base64,',
                        //Add SVG in base64.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        //Setting prefix data:application/json;base64
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        console.log("\n--------------------");
        console.log(
            string(
                abi.encodePacked(
                    "https://nftpreview.0xdev.codes/?code=",
                    finalTokenUri
                )
            )
        );
        console.log("--------------------\n");

        //Mint NFT to the sender who activated the contract
        _safeMint(msg.sender, newItemId);
        //Designate NFT data
        _setTokenURI(newItemId, finalTokenUri);
        //Increment counter for next mint
        _tokenIds.increment();
        console.log("NFT ID %s minted for %s", newItemId, msg.sender);
    }
}
