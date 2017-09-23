pragma solidity ^0.4.11;

contract BlokkChatGroup {
    /*
    IPFS stores its hashes as a multihash -- the first two bytes represent
    the hash function used (default SHA256) and the length of the hash,
    which is typically 0x12 = SHA256 and 0x20 = 32 bytes (256 bits)
    */
    struct IpfsMultihash {
        uint8 hashFunction; //first byte of multihash
        uint8 hashLength; //second byte of multihash
        bytes hash; //hashLength remaining bytes of multihash
    }

    uint256 postCount = 0;

    struct Post {
        string title; //length limit enforced by ruleset, must be unique, immutable
        uint256 number; //must be > 0 if post exists, unique, immutable
        string contentType; //MIME-type of content
        IpfsMultihash contentAddress; //required only if enforced by ruleset
        address creator; //immutable
        uint256 creationTime; //UNIX timestamp, accept user input bounded by block.timestamp, immutable
        address groupAddress; //null when group has not been created for this post
        uint256 balance; //amount of money owned by this post in this group
        int256 permissions; //permission level of post
    }

    mapping (string => Post) postsByTitle;
    mapping (address => uint256[]) postNumbersByCreator;
    mapping (uint256 => Post) postsByNumber;

    event NewPost(address indexed creator, uint256 indexed number, string title);

    uint256 userCount = 0;

    struct User {
        string nickname; //length/uniqueness enforced by ruleset
        uint256 number; //must be > 0 if user exists, unique, immutable
        string profileType; //MIME-type of profile
        IpfsMultihash profileAddress; //required only if enforced by ruleset
        address addr; //public key, unique, immutable
        uint256 joinTime; //UNIX timestamp when user first joined group, use block.timestamp, immutable
        address directAddress; //null when user has not created/linked a private group (for direct messaging)
        uint256 balance; //amount of money owned by this user in this group
        int256 permissions; //permission level of user, permit negatives for banned/muted/etc type users, also use largest type to permit flags instead of linear values
    }

    mapping (address => User) usersByAddress; //maps ethereum addres (public key) to user objects
    mapping (uint256 => User) usersByNumber;

    function getPostByTitle(string _title) constant returns (
        string title,
        uint256 number,
        string contentType,
        IpfsMultihash contentAddress,
        address creator,
        uint256 creationTime,
        address groupAddress,
        uint256 balance,
        int256 permissions
    ) {
        Post memory p = postsByTitle[_title];
        return (
            p.title,
            p.number,
            p.contentType,
            p.contentAddress,
            p.creator,
            p.creationTime,
            p.groupAddress,
            p.balance,
            p.permissions
        );
    }

    function getPostByNumber(uint256 _number) constant returns (
        string title,
        uint256 number,
        string contentType,
        IpfsMultihash contentAddress,
        address creator,
        uint256 creationTime,
        address groupAddress,
        uint256 balance,
        int256 permissions
    ) {
        Post memory p = postsByNumber[_number];
        return (
            p.title,
            p.number,
            p.contentType,
            p.contentAddress,
            p.creator,
            p.creationTime,
            p.groupAddress,
            p.balance,
            p.permissions
        );
    }

    function getPostNumbersByCreator(address _creator) constant returns (uint256[]) {
        return (postNumbersByCreator[_creator]);
    }

    function postExists(string title) returns (bool) {
        return (getPostByTitle(title).number != 0);
    }

    function createPost(string title, string contentType, uint8 ipfsHashFunction, uint8 ipfsHashLength, bytes ipfsHash, uint256 creationTime) returns (uint256) {
        //TODO: check title length via ruleset
        //TODO: UTF-8 length != bytes().length
        require(bytes(title).length <= 255);

        require(!postExists(title));

        require(ipfsHashLength != 0);

        require(ipfsHashLength == ipfsHash.length);

        //TODO: check if ipfs hash is 32 bytes long

        uint256 ctLen = bytes(contentType).length;
        require(ctLen > 0 && ctLen <= 255); //RFC 6838 limits mime types to 127 bytes for each of the major and minor types, plus the separating slash

        if (creationTime > block.timestamp || creationTime <= (block.timestamp - 1 hours)) {
            creationTime = block.timestamp;
        }

        address creator = msg.sender;

        postCount++;

        Post memory newPost = Post({
            title: title,
            number: postCount,
            contentType: contentType,
            contentAddress: IpfsMultihash({
                hashFunction: ipfsHashFunction,
                hashLength: ipfsHashLength,
                hash: ipfsHash
            }),
            creator: creator,
            creationTime: creationTime,
            groupAddress: 0,
            balance: 0, //TODO: default from ruleset
            permissions: 0 //TODO: default from ruleset
        });

        postsByTitle[title] = newPost;
        postsByCreator[creator].push(newPost);
        postsByNumber[postCount] = newPost;

        NewPost(creator, postCount, title);

        return (postCount);
    }

}

