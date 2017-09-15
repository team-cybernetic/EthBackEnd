var BlokkCreator = artifacts.require("./BlokkCreator.sol");
var BlokkChat = artifacts.require("./BlokkChat.sol");


module.exports = function(deployer) {
  deployer.deploy(BlokkCreator);
  deployer.deploy(BlokkChat);
  deployer.link(BlokkChat,BlokkCreator);
};
