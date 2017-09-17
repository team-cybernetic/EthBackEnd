pragma solidity ^0.4.2;

import "./BlokkChat.sol";

contract BlokkCreator {
	BlokkChat scope;
	function BlokkCreator() {
		BlokkChat root = new BlokkChat("root");
		scope = root;
	}

	function createGroup(bytes32 groupName) public returns (BlokkChat) {
		BlokkChat newGroup = new BlokkChat(groupName);
		scope.createGroup(groupName, newGroup);
		newGroup.setParent(scope);
		scope = newGroup;
	}

	function scopeParent() public returns (int) {
		scope = scope.getParent();
	}
}