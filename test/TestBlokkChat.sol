pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BlokkChat.sol";

contract TestBlokkChat {

  function testCreateGroup() {
    BlokkChat root = new BlokkChat("root");
    int i = 1;
    int j = root.createGroup("okonkwo");
    Assert.equal(i, j, "check if method call works");
  }

}
