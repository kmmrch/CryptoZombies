pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

event NewZombie(uint zombieId, string name, uint dna); // let the front-end know every time a new zombie is created

    // this will be permanently stored in the blockchain
    uint dnaDigits = 16; // zombie's dna is determinated by a 16 digit number
    uint dnaModulus = 10 ** dnaDigits; // make sure the dna has ONLY 16 characters
    
    struct Zombie {
        string name;
        uint dna;
    }
    
    Zombie[] public zombies; // stores an army of zombies
    
    function _createZombie(string memory _name, uint _dna) private { // private function names start with an underscore (_)
    uint id = zombies.push(Zombie(_name, _dna)) - 1; // adds the new zombie to the zombies array
        emit NewZombie(id, _name, _dna);
    }
    
    function _generateRandomDna(string memory _str) private view returns (uint) { //views some f the contract's variabes but don't modify them
        uint rand = uint(keccak256(abi.encodePacked(_str))); // generate a pseudo-random hexadecimal
        return rand % dnaModulus;
    }
    
    function createRandomZombie(string memory _name) public { // takes the zombie's name and use it to create a zombie with random dna
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
