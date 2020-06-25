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
    bool debugmode;


    event OwnerAction(address owner, string action);
    event Alert(address addr, string msg);
        
    modifier isOwner(string memory functionname) {  // owner validiation
        emit Alert(msg.sender, functionname);  // who called this function
        if(!debugmode){
            require(msg.sender == owner, "Invalid call!");  // check validation of owner
        }
        _;  // execute the original code
    }
    
    modifier isAllowedContract(string memory functionname) {
        emit Alert(msg.sender, functionname);
        require(whitelist[msg.sender], "invalid contract accessed");
        _;
    }
    
    constructor() public{  // constructor, create the contract and enroll the owner
        owner = msg.sender;
        debugmode = true;
        emit OwnerAction(msg.sender, "Owner enrolled.");
        reason.push("decease");
        reason.push("migration");
        reason.push("banishment");
    }
    
    function enrollment(address addr) public isOwner("enrollment() called"){  // 새 did 추가
        Info memory info = Info(true, "");
        verifier[addr] = info;
    }
    
    function debugmodectl(bool mode) public {
        emit Alert(msg.sender, "debugmode changed!");
        debugmode = mode;
    }


    function disenrollment(address addr, uint8 reasonid) public isOwner("disenrollment() called"){  // did 제거
        verifier[addr].cancellationReason = reason[reasonid];
        invalidation(addr);
    }
    
    function invalidation(address addr) private{  // did 제거
        verifier[addr].isKorean = false;
    }
    
    function addReason(string memory reasonStr) public isOwner("addReason() called"){  // did 제거 이유 추가
        reason.push(reasonStr);
    }
    
    function viewReason() external view returns(string[] memory) {  // did 제거 이유 보기
        return reason;
    }
    
    function addWhitelist(address addr) public isOwner("addWhitelist() called"){  // did 호출할 수 있는 whitelist 주소 추가
        whitelist[addr] = true;
    }
    
    function removeWhitelist(address addr) public isOwner("removeWhitelist() called"){  // did 호출할 수 있는 whitelist 주소 제거
        whitelist[addr] = false;
    }
    
    function checkValidation(address addr) public isAllowedContract("checkValidation() called") returns(bool) {  // 유효한 did 여부 확인
        if(verifier[addr].isKorean){
            return true;
        }
        return false;
    }
}