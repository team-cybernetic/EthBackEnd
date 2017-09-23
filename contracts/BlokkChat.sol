pragma solidity ^0.4.2;


contract BlokkChat {

	struct IpfsMultihash {
        uint8 hashFunction; //first byte of multihash
        uint8 hashLength; //second byte of multihash
        bytes hash; //hashLength remaining bytes of multihash
    }

    uint256 postCount = 0;

    struct Post {
        string title; //length limit enforced by ruleset, must be unique, immutable
        uint256 number; //unique, immutable
        IpfsMultihash contentAddress; //required only if enforced by ruleset
        address creator; //immutable
        uint256 creationTime; //UNIX timestamp, accept user input bounded by block.timestamp, immutable
        address groupAddress; //null when group has not been created for this post
        uint256 balance; //amount of money owned by this post in this group
        int256 permissions; //permission level of post
    }

    mapping (string => Post) postsByTitle;
    mapping (address => Post[]) postsByCreator;
    mapping (uint256 => Post) postsByNumber;

    uint256 userCount = 0;

    struct User {
        string nickname; //length/uniqueness enforced by ruleset
        uint256 number; //unique, immutable
        IpfsMultihash profileAddress; //required only if enforced by ruleset
        address addr; //public key, unique, immutable
        uint256 joinTime; //UNIX timestamp when user first joined group, use block.timestamp, immutable
        address directAddress; //null when user has not created/linked a private group (for direct messaging)
        uint256 balance; //amount of money owned by this user in this group
        int256 permissions; //permission level of user, permit negatives for banned/muted/etc type users, also use largest type to permit flags instead of linear values
    }

    mapping (address => User) usersByAddress; //maps ethereum addres (public key) to user objects
	mapping (uint256 => User) usersByNumber;


	address[] subgroups;
	bytes32 groupName;

	uint256 exchangeRate;


	mapping(bytes32 => address) children;
	BlokkChat parent;

	function BlokkChat(bytes32 name) {
		groupName = name;
	}
	
	/// @notice create a joinable group with a custom ruleset
	/// @param name the name of the group to be create
	/// @return 1 on success, error code on failure
	function createGroup(bytes32 name, address groupContract) public returns (int) {
		children[name] = groupContract;
	}

	function setParent(BlokkChat newParent) public {
		parent = newParent;
	}

	function getParent() public returns (BlokkChat) {
		return parent;
	}

	/// @notice adds a user to the member list for a group
	/// @return The number for the user if a user with the given address exists, null otherwise
	function addMember(string nickname, uint256 number, address addr) public returns (uint256) {
		if (usersByAddress[addr].addr == 0 && usersByNumber[number].addr == 0) {
			User memory temp = User(nickname, number, IpfsMultihash(0,0,''), addr, 0, 0, 0, 0);
			usersByAddress[addr] = temp;
			usersByNumber[number] = temp;
			return number;
		} else {
			if(usersByAddress[addr].addr == 0) {
				return 0;
			}
			else {
				return usersByAddress[addr].number;
			}
		}
		
	}

	/// @notice purchase currency token for a group
	/// @return the number of tokens that have been purchased after conversion
	function buyIn() payable returns (uint) {
		User storage recipient = usersByAddress[msg.sender];
		recipient.balance += msg.value * exchangeRate;
		return recipient.balance;
	}

	/// @notice exit a group you are currently a member of
	/// @return 1 on success, error code on failure
	function leaveGroup() public returns (int) {
		User storage temp = usersByAddress[msg.sender];
		withdrawalFunds(temp.balance);
		temp.addr = 0;
		temp.number = 0;
		return 1;
	}


	/// @notice create a post
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
	/// @return the new balance of the user
	function withdrawalFunds(uint amount) public returns (uint) {
		User storage recipient = usersByAddress[msg.sender];
		uint actualReceipt = amount / exchangeRate; //can only send a multiple of the exchangeRate...
		recipient.balance -= actualReceipt * exchangeRate;
		msg.sender.transfer(amount);
		return recipient.balance;
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
	function getChildren(string path) public returns (string) {
		return "";
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
	function getUsers(string path) public returns (string){
		return "";
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