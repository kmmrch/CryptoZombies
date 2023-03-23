pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }
  // here the user will be able to change their zombies' names
  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }
  //here the user will be ble to give the zombies custom dna
  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }
  // this function will return a user's entire zombie army
  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
  uint[] memory result = new uint[](ownerZombieCount[_owner]);
  uint counter = 0; // keep track of the index in the result array
    for (uint i = 0; i < zombies.length; i++) { // iterates through all the zombies in the array
      if (zombieToOwner[i] == _owner) { // compare two addresses to see if they match
        result[counter] = i;
        counter++;
      }
    }
  return result;
  }

}
