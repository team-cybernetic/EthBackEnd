pragma solidity ^0.4.2;
import "./BlokkChat.sol";

contract BlokkCreator {
	function createGroup(string groupName) public returns (BlokkChat) {
		return new BlokkChat(groupName);
	}
}