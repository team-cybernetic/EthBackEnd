pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

contract BlokkChat {
	
	/// @notice create a joinable group with a custom ruleset
	/// @param path the path to the context at which the group should be created
	/// @param groupName the name of the group to be create
	/// @return 1 on success, error code on failure
	function createGroup(string path, string groupName) public returns (int) {
		return 1;
	}

	/// @notice adds a user to the member list for a group
	/// @param user identifying string for user to be added
	/// @param group full path to the group which is to be added
	/// @param auth Authentication key to confirm privilege in order to perform moderation action(implementation to be determined)
	/// @return 1 on success, error code on failure
	function addMember(string user, string group, string auth) public returns (int) {
		return 1;
	}

	/// @notice purchase currency token for a group
	/// @param amount the amount of eth to be converted into tokens
	/// @return the number of tokens that have been purchased after conversion
	function buyIn(uint amount) public returns (uint) {
		return 0;
	}

	/// @notice exit a group you are currently a member of
	/// @param user identifying string for user which wants to leave
	/// @param group the path to the group that the user wishes to leave
	/// @param auth authentication key to confirm privilege to leave group
	/// @return 1 on success, error code on failure
	function leaveGroup(string user, string group, string auth) public returns (int) {
		return 1;
	}

	/// @notice create a post
	/// @param user identifying string for user that wants to create the post
	/// @param group the path to the group that the user wants to post in
	/// @param auth authentication key to confirm privilege to make the post
	/// @param title the title of the post
	/// @param body the body of the post
	/// @return path to the created post
	function createPost(string user, string group, string auth, string title, string body, string path) public returns (string) {
		return "";
	}

	/// @notice delete a post
	/// @param user identifying string for user that wants to delete post
	/// @param group the path to the post the user wants deleted
	/// @param auth authentication key to confirm privilege to delete the post
	/// @return 1 on success, error code on failure
	function deletePost(string user, string group, string auth) public returns (int) {
		return 1;
	}

	/// @notice gets the current Ether holdings of the group
	/// @param group the path to the group
	/// @return the current Etherium holdings of the group
	function getBalEth(string group) public returns (uint) {
		return 0;
	}

	/// @notice get the current number of existing tokens in the group
	/// @param group the path to the group
	/// @return the current number of existing tokens in the group
	function getBalInternal(string group) public returns (uint) {
		return 0;
	}

	/// @notice converts the token holdings of the user into Ether to be withdrawn
	/// @param group the group to be withdrawn from
	/// @param amount the number of tokens the user would like to withdrawal
	/// @param user the identifying string of the user
	/// @param auth the authorization string to identify privilege
	/// @param addr the Etherium wallet address for the funds to be transferred to
	/// @return the resulting Eth to be credited to the user 
	function withdrawalFunds(string group, uint amount, string user, string auth, address addr) public returns (uint) {
		return 0;
	}

	/// @notice transfer token balance from one individual to another within a group
	/// @param fromUser identifying string for user who wishes to transfer funds
	/// @param toUser identifying string for user who user wishes to transfer to
	/// @param amount the amount to transfer
	/// @param auth authorization key to confirm privilege of transfer
	/// @return number of tokens transferred on success, error code on failure
	function transferBal(string fromUser, string toUser, uint amount, string auth) public returns (int) {
		return 0;
	}

	/// @notice get the child groups/posts of given group/post
	/// @param path the path to the group or post you wish to find children of
	/// @return an array containing the children of the group/post
	function getChildren(string path) public returns (string[]) {
		return new string[](0);
	}

	/// @notice spend tokens to "like" a post, increasing visibility and rewarding the posting user
	/// @param user identifying string for the user who wants to like the post
	/// @param path the path to the recipient post
	/// @param amount the number of tokens to be rewarded
	/// @param auth an authentication key to confirm privilege
	/// @return the new "like/dislike" balance of the recipient post
	function likePost(string user, string path, uint amount, string auth) public returns (int) {
		return 0;
	}

	/// @notice spend tokens to "dislike" a post, decreasing visibility and penalizing the posting user
	/// @param user identifying string for the user who wants to dislike the post
	/// @param path the path to the recipient post
	/// @param amount the number of tokens to be used
	/// @param auth an authentication key to confirm privilege
	/// @return the new "like/dislike" balance of the recipient post
	function dislikePost(string user, string path, uint amount, string auth) public returns (int){
		return 0;
	}

	/// @notice gets the number of members in a group
	/// @param path the path to the group
	/// @return a list of users of the group
	function getUsers(string path) public returns (string[]){
		return new string[](0);
	}

	/// @notice adds locked state to group, preventing new posts from being created
	/// @param path the path to the group that is to be locked
	/// @param user identification string for user that wishes to lock the group
	/// @param auth the authorization key to confirm privilege
	/// @return the new locked state of the group (TRUE if locked, FALSE otherwise)
	function lockGroup(string path, string user, string auth) public returns (bool) {
		return true;
	}

	/// @notice removes locked state from group, allowing new posts to be created
	/// @param path the path to the group that is to be unlocked
	/// @param user identification string for user that wishes to lock the group
	/// @param auth the authorization key to confirm privilege
	/// @return the new locked state of the group (TRUE if locked, FALSE otherwise)
	function unlockGroup(string path, string user, string auth) public returns (bool) {
		return false;
	}

	/// @notice change the ruleset for a group
	/// @param path the path to the group you wish to changes rules of
	/// @param oldRuleset the address of the old ruleset
	/// @param newRuleset the address of the updated ruleset
	/// @param funds the funds the user is willing to provide towards accomplishing this action
	/// @param user the identifying string for the user 
	/// @param auth the authorization key to confirm privilege
	/// @return 1 on success, error code otherwise
	function changeRules(string path, address oldRuleset, address newRuleset, uint funds, string user, string auth) public returns (int) {
		return 1;
	}

	/// @notice kick a user from the group
	/// @param path the path to the group to kick the user from
	/// @param funds the funds the user is willing to provide towards accomplishing this action
	/// @param user the identifying string for the kicking user 
	/// @param target the user to be kicked
	/// @param auth the authorization key to confirm privilege
	/// @return 1 on success, error code otherwise
	function kickUser(string path, uint funds, string user, string target, string auth) public  returns (int) {
		return 1;
	}

	/// @notice ban a user from the group
	/// @param path the path to the group to ban the user from
	/// @param funds the funds the user is willing to provide towards accomplishing this action
	/// @param user the identifying string for the banning user 
	/// @param target the user to be banned
	/// @param time how long the user is to be banned for, in minutes
	/// @param auth the authorization key to confirm privilege
	/// @return 1 on success, error code otherwise
	function banUser(string path, uint funds, string user, string target, uint time, string auth) public returns (int) {
		return 1;
	}

	/// @notice mute a user
	/// @param path the path to the group to mute the user in
	/// @param funds the funds the user is willing to provide towards accomplishing this action
	/// @param user the identifying string for the muting user 
	/// @param target the user to be muted
	/// @param time how long the user is to be muted for, in minutes
	/// @param auth the authorization key to confirm privilege
	/// @return 1 on success, error code otherwise
	function muteUser(string path, uint funds, string user, string target, uint time, string auth) public returns (int) {
		return 1;
	}

	/// @notice vote towards a moderation action
	/// @param funds the funds to be put towards the moderation action
	/// @param user the identifying string for contributing user
	/// @param auth the authorization key to confirm privilege
	/// @return the new balance of the voting action on success, error code otherwise
	function voteAction(uint funds, string user, string auth) public returns (int) {
		return 1;
	}
}