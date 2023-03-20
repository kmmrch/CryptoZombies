pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
// this will be permanently stored in the blockchain
    uint dnaDigits = 16; // zombie's dna is determinated by a 16 digit number
    uint dnaModulus = 10 ** dnaDigits; // make sure the dna has ONLY 16 characters
    
    struct Zombie {
        string name;
        uint dna;
    }
    
    Zombie[] public zombies; // stores an army of zombies
    
    function createZombie(string memory _name, uint _dna) public {
    zombies.push(Zombie(_name, _dna)); // adds the new zombie to the zombies array
    }
}
