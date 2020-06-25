pragma solidity >=0.5.17 <0.7.0;
pragma experimental ABIEncoderV2;

contract Administrator {
    struct Info {  // contents of each id
        bool isKorean;  // default: False, it will change to True when enrolled
        string cancellationReason;  // invalidation reason
    }
    
    mapping(address=>Info) verifier;  // all ids
    string[] reason;  // reason for invalidation
    mapping(address=>bool) whitelist;
    
    address private owner; // owner as Administrator
    
    event OwnerAction(address owner, string action);
    event Alert(address addr, string msg);
    
    
    modifier isOwner(string memory functionname) {  // owner validiation
        emit Alert(msg.sender, functionname);  // who called this function
        require(msg.sender == owner, "Invalid call!");  // check validation of owner
        _;  // execute the original code
    }
    
    modifier isAllowedContract(string memory functionname) {
        emit Alert(msg.sender, functionname);
        require(whitelist[msg.sender], "invalid contract accessed");
        _;
    }
    
    constructor() public{  // constructor, create the contract and enroll the owner
        owner = msg.sender;
        emit OwnerAction(msg.sender, "Owner enrolled.");
        reason.push("decease");
        reason.push("migration");
        reason.push("banishment");
    }
    
    function enrollment(address addr) public isOwner("enrollment() called"){  // enroll a new person as a member
        Info memory info = Info(true, "");
        verifier[addr] = info;
    }
    
    function disenrollment(address addr, uint8 reasonid) public isOwner("disenrollment() called"){
        verifier[addr].cancellationReason = reason[reasonid];
    }
    
    function invalidation(address addr) private{
        verifier[addr].isKorean = false;
    }
    
    function addReason(string memory reasonStr) public {  // reason addition
        reason.push(reasonStr);
    }
    
    function viewReason() external view returns(string[] memory) {
        return reason;
    }
    
    function addWhitelist(address addr) public isOwner("addWhitelist() called"){
        whitelist[addr] = true;
    }
    
    function removeWhitelist(address addr) public isOwner("removeWhitelist() called"){
        whitelist[addr] = false;
    }

    
    function checkValidation(address addr) public isAllowedContract("checkValidation() called") returns(bool) {
        if(verifier[addr].isKorean){
            return true;
        }
        return false;
    }
    
}