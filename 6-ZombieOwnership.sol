pragma solidity >=0.5.0 <0.6.0;

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

function balanceOf(address _owner) external view returns (uint256) {
    return ownerZombieCount[_owner]; // return the number of zombies the user has here
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return zombieToOwner[_tokenId]; // return the owner of "_tokenId"
  }
  
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerZombieCount[_to]++; // keep track of how many zombies an owner has
    ownerZombieCount[_from]--; // keep track of who owns what
    zombieToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {

  }

  function approve(address _approved, uint256 _tokenId) external payable {

  }
}
