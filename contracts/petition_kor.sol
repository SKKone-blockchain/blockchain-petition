pragma solidity >=0.5.17 <0.7.0;

contract Petition{
    
    address governer;
    address owner;
    
    struct Contents {
        string title;
        string content;
        string[] tags;
        uint256 vote;
    }
    
    mapping(bytes32=>bool) votecheck;
    mapping(uint256=>Contents) petitions;
    
    
    constructor(address addr) public{
        owner = msg.sender;
        governer = addr;
    }
    
    function vote(uint256 _id) public returns(bool) {
        bytes32 addrhash = keccak256(toBytes(msg.sender));
        bytes32 idhash = keccak256(abi.encodePacked(_id));
        bytes32 checkhash = keccak256(abi.encodePacked(addrhash ^ idhash));   
        
        petitions[_id].vote += 1;
        votecheck[checkhash] = true;
        return true;
    }
    
    function write() public{
        title
    }
    
    
    function toBytes(address addr) private returns(bytes memory) {
        bytes memory byteaddr = new bytes(20);
        for (uint8 i = 0; i < 20; i++) {
            byteaddr[i] = byte(uint8(uint(addr) / (2**(8*(19 - i)))));
        }
        return (byteaddr);
    }
    
}