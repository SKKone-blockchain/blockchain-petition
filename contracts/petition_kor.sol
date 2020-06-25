pragma solidity >=0.5.17 <0.7.0;
pragma experimental ABIEncoderV2;

contract Administrator {
    function checkValidation(address) public returns(bool) { }
}


contract Petition{
    struct Contents {
        string title;
        string content;
        string[] tags;
        uint256 vote;
        uint256 starttime;
        string reply_url;
        bool isreplied;
    }

    Administrator governer;
    address owner;
    uint256 id;
    mapping(bytes32=>bool) votecheck;  // 해당 청원에 vote 했는지 여부 저장
    mapping(uint256=>Contents) petitions;  // 청원 저장
    
    
    modifier votechecker(uint256 _id) {
        bytes32 addrhash = keccak256(toBytes(msg.sender));
        bytes32 idhash = keccak256(abi.encodePacked(_id));
        bytes32 checkhash = keccak256(abi.encodePacked(addrhash ^ idhash));
        require(!votecheck[checkhash], "already voted here.");
        votecheck[checkhash] = true;
        _;
    }
    
    
    // check if he is korean
    modifier getValidation() {
        require(governer.checkValidation(msg.sender), "invalid access");
        _;
    }
    

    constructor(address addr) public{
        owner = msg.sender;
        governer = Administrator(addr);
        id = 0;
    }
    

    function vote(uint256 _id) public returns(bool) {
        petitions[_id].vote += 1;
        return true;
    }
    
    
    function write(string memory title, string memory content, string[] memory tags) public {
        petitions[id].title = title;
        petitions[id].content = content;
        for (uint i = 0; i < tags.length; i++){
            petitions[id].tags.push(tags[i]);
        }
        petitions[id].vote = 0;
        id++;
    }
    
    
    function viewContent(uint256 _id) external view returns(Contents memory) {
        return petitions[_id];
    }
    
    
    function getContentsList(uint _start, uint _end) external view returns(Contents[] memory) {
        Contents[] memory list = new Contents[](_end-_start);
        for(uint i = _start; i < _end+1; i++){
            list[i] = (petitions[i]);
        }
        return list;
    }
    
    
    function toBytes(address addr) private pure returns(bytes memory) {
        bytes memory byteaddr = new bytes(20);
        for (uint8 i = 0; i < 20; i++) {
            byteaddr[i] = byte(uint8(uint(addr) / (2**(8*(19 - i)))));
        }
        return (byteaddr);
    }
    
}