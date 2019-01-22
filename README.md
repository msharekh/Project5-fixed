# Project5 - Decentralized Star Notary

In this project, we build a Decentralized Star Notary Service that allows users to create and exchange stars.
This application is build usijng solidity, Truffle , web3

## Download project

```
git clone https://github.com/msharekh/Project5-fixed.git

```

## Installation

#### Install project dependencies:

```
$ npm install -g truffle@4.1.15
$ npm install openzeppelin-solidity@2.0 --save
$ npm install --save truffle-hdwallet-provider

```

## Important Info

#### ERC-721 Token Name: MSH StarNotary

#### ERC-721 Token Symbol: MSH

#### Token Address on the Rinkeby Network:

## functions:

#### Add a name and a symbol to the starNotary tokens

set name and set symbol by passing them to setName and setSymbol

#### Lookup a star by ID

using lookUptokenIdToStarInfo function

#### transfer token from one user to another

using function transferStar we are passing parameters from and to addresses and starid

#### users can exchange their stars

1. User 1 puts his/her star for sale
2. User 2 puts his/her star for sale
3. User 1 calls the function exchangeStars, to get the star
   from User 2 that is on sale, in exchange of his/her star that is on sale
   The user 1 provides the following parameters to exchangeStars:
   id token star for sale user 1, id token star for sale user 2
