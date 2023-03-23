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

address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress); // set up the contract to read from CryptoKitties smart contract

function feedAndMultiply(uint _zombieId, uint _targetDna, string memoy _species) public {
    require(msg.sender == zombieToOwner[_zombieId]); // verify if msg.sender is the zombie's owner
    Zombie storage myZombie = zombies[_zombieId]; // get the zombie's dna
    _targetDna = _targetDna % dnaModulus; // make sure the dna isn't longer than 16 digits
    uint newDna = (myZombie.dna + _targetDna) / 2; // generate a new dna
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99; // replace the last two digits of the dna with "99"
    }
    _createZombie("NoName", newDna);
  }

function feedOnKitty(uint _zombieId, uint _kittyId) public { // interact with CryptoKitties' contract
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }
}
