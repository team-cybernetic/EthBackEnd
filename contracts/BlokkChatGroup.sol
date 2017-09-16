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
}
