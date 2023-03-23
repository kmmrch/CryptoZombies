pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
);
}

contract ZombieFeeding is ZombieFactory {

KittyInterface kittyContract; // changed this line to just declare a variable

modifier ownerOf(uint _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    _;
  }

function setKittyContractAddress(address _address) external onlyOwner {
    kittyContract = KittyInterface(_address);
  }
  
  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime);
  }

  function _isReady(Zombie storage _zombie) internal view returns (bool) { // tell us if enough time has passed since the last time the zombie fed
      return (_zombie.readyTime <= now);
  }

function feedAndMultiply(uint _zombieId, uint _targetDna, string memoy _species) internal ownerOf(_zombieId) {
    
    Zombie storage myZombie = zombies[_zombieId]; // get the zombie's dna
    require(_isReady(myZombie)); // the user can only execute this function if the zombie's cooldowntime is over
    _targetDna = _targetDna % dnaModulus; // make sure the dna isn't longer than 16 digits
    uint newDna = (myZombie.dna + _targetDna) / 2; // generate a new dna
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99; // replace the last two digits of the dna with "99"
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie); // make feeding triggers the zombie's cooldown time
  }

function feedOnKitty(uint _zombieId, uint _kittyId) public { // interact with CryptoKitties' contract
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}
