pragma solidity >=0.5.0 <0.6.0;

import "./ownable.sol";
import "./safemath.sol";

contract ZombieFactory is Ownable {

using SafeMath for uint256;

event NewZombie(uint zombieId, string name, uint dna); // let the front-end know every time a new zombie is created

    // this will be permanently stored in the blockchain
    uint dnaDigits = 16; // zombie's dna is determinated by a 16 digit number
    uint dnaModulus = 10 ** dnaDigits; // make sure the dna has ONLY 16 characters
    uint cooldownTime = 1 days; // make zombies wait 1 day before attackig or feeding to attack again
    
    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime; // this will be used to implement a cooldown timer
        uint16 winCount;
        uint16 lossCount;
    }
    
    Zombie[] public zombies; // stores an army of zombies
    
    mapping (uint => address) public zombieToOwner; //keeps track of the address that owns a zombie
    mapping (address => uint) ownerZombieCount; // keeps track of how many zombies an owner has
    
    function _createZombie(string memory _name, uint _dna) internal { // private function names start with an underscore (_)
    uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1; // adds the new zombie to the zombies array with 0 wins and 0 losses
    zombieToOwner[id] = msg.sender; // assign ownership to whoever called the function
    ownerZombieCount[msg.sender]++;
    emit NewZombie(id, _name, _dna);
    }
    
    function _generateRandomDna(string memory _str) private view returns (uint) { //views some f the contract's variabes but don't modify them
        uint rand = uint(keccak256(abi.encodePacked(_str))); // generate a pseudo-random hexadecimal
        return rand % dnaModulus;
    }
    
    function createRandomZombie(string memory _name) public { // takes the zombie's name and use it to create a zombie with random dna
        require(ownerZombieCount[msg.sender] == 0); // make sure the function only gets executed once per user
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
