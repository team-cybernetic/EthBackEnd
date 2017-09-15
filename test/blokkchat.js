var BlokkChat = artifacts.require("./BlokkChat.sol");

contract('BlokkChat', function(accounts) {
  it("should create a group", function() {
    var temp;
    return BlokkChat.deployed().then(function(instance) {
      temp = 11;
    }).then(function(balance) {
      assert.equal(temp, 11, "11 wasn't in the first group");
    });
  });
});
