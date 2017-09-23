pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BlokkCreator.sol";
import "../contracts/BlokkChat.sol";

contract TestBlokkChat {

  //this isn't a thorough test at all, just been changing it to test each method...
  function testCreateGroup() {
    BlokkCreator root = new BlokkCreator();
    int256 i = 1;
    BlokkChat b = root.createGroup("child");
    root.scopeParent();
    Assert.equal(i, 1, "check if method call works");
  }

}
