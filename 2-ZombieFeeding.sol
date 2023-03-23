pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]); // verify if msg.sender is the zombie's owner
    Zombie storage myZombie = zombies[_zombieId]; // get the zombie's dna
    _targetDna = _targetDna % dnaModulus; // make sure the dna isn't longer than 16 digits
    uint newDna = (myZombie.dna + _targetDna) / 2; // generate a new dna
    _createZombie("NoName", newDna);
  }

}
