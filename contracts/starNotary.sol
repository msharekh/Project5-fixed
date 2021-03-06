pragma solidity ^0.4.23;

import 'openzeppelin-solidity/contracts/token/ERC721/ERC721.sol';

contract StarNotary is ERC721 {

    struct Star {
        string name;
    }

//  Add a name and a symbol for your starNotary tokens

// #### ERC-721 Token Name: MSH StarNotary 
// #### ERC-721 Token Symbol: MSH

    string public  name = "MAS StarNotary";
    string public  symbol ="MAS";
    uint8 public decimal = 18;
    // uint256 public totalSupply = 1000000;
    uint _totalSupply ;

    // Balances for each account stored using a mapping
    mapping(address => uint256) balances;

    constructor() public {
        uint amount =1000000;
        _totalSupply = amount;
        balances[msg.sender] = amount;
    }

    // Returns the total supply of tokens
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }

    function setName(string _name) public{
        name = _name;
    }

    function setSymbol(string _symbol) public{
        symbol = _symbol;
    }
//

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    function createStar(string _name, uint256 _tokenId) public {
        Star memory newStar = Star(_name);

        tokenIdToStarInfo[_tokenId] = newStar;

        _mint(msg.sender, _tokenId);
    }

// Add a function lookUptokenIdToStarInfo, that looks up the stars using the Token ID, and then returns the name of the star.
    function lookUptokenIdToStarInfo(uint256 _tokenId) public view returns (string ) {
        Star memory s = tokenIdToStarInfo[_tokenId];
        return s.name;
    }
//

    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender);

        starsForSale[_tokenId] = _price;
    }

    function buyStar(uint256 _tokenId) public payable {
        require(starsForSale[_tokenId] > 0);

        uint256 starCost = starsForSale[_tokenId];
        address starOwner = ownerOf(_tokenId);
        require(msg.value >= starCost);

        _removeTokenFrom(starOwner, _tokenId);
        _addTokenTo(msg.sender, _tokenId);

        starOwner.transfer(starCost);

        if(msg.value > starCost) {
            msg.sender.transfer(msg.value - starCost);
        }
        starsForSale[_tokenId] = 0;
    }

// Add a function called exchangeStars, so 2 users can exchange their star tokens...
//Do not worry about the price, just write code to exchange stars between users.

    function exchangeStars(uint256 _tokenId1, uint256 _tokenId2) public{

        // 1) User 1 puts his/her star for sale
        

        // 2) User 2 puts his/her star for sale

        // 3) User 1 calls the function exchangeStars, to get the star 
        address user1 = ownerOf(_tokenId1);
        address user2 = ownerOf(_tokenId2);

        //exchanging ..
        _removeTokenFrom(user1, _tokenId1);
        _addTokenTo( user2, _tokenId1);
        _removeTokenFrom(user2, _tokenId2);
        _addTokenTo( user1, _tokenId2);

        require(_checkOnERC721Received(user1, user2, _tokenId1, ""));
        require(_checkOnERC721Received(user2, user1, _tokenId1, ""));

    }





// Write a function to Transfer a Star. The function should transfer a star from the address of the caller.
// The function should accept 2 arguments, the address to transfer the star to, and the token ID of the star.
//
    function transferStar(address _to, uint256 _tokenId) public{
                
        _removeTokenFrom(msg.sender, _tokenId);
        _addTokenTo(_to, _tokenId);

        emit Transfer(msg.sender, _to, _tokenId);
    }
}
