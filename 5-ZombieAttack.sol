pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;

  function randMod(uint _modulus) internal returns(uint) {
    randNonce = randNonce.add(1);
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }
  
  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    // get pointers to both zombies to easily interact with them:
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100); // determine the outcome of the battle
    if (rand <= attackVictoryProbability) {
      myZombie.winCount = myZombie.winCount.add(1);
      myZombie.level = myZombie.level.add(1); // level up!
      enemyZombie.lossCount = enemyZombie.lossCount.add(1); // loser!
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    }else {
      myZombie.lossCount = myZombie.lossCount.add(1);
      enemyZombie.winCount = enemyZombie.winCount.add(1);
      _triggerCooldown(myZombie); // cooldown will be triggered whether the zombie wins or loses
    }
  }
}  
