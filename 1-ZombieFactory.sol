pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
// this will be permanently stored in the blockchain
    uint dnaDigits = 16; // zombie's dna is determinated by a 16 digit number
    uint dnaModulus = 10 ** dnaDigits; // make sure the dna has ONLY 16 characters
}
