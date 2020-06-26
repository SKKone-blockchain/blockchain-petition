<h1> Contracts Usage </h1>

<h2> did_kor.sol - Administrator </h2>

한국인임을 증명해주는 역할을 하는 Contract <br/>
정부 시스템에 블록체인 시스템이 적용되어 출생, 이민과 같이 새로운 한국인 등록이 필요할 때 자동으로 등록이 된다고 가정 <br/>
하지만 현재는 그런 시스템이 구축이 되어있지 않으므로 enrollment 기능을 통해 한국인을 등록 <br/>

개인 이더리움 계정 주소를 입력하여 한국인임을 등록하면 현재 did_kor 컨트랙트에 did가 기록된다 <br/>
did를 등록하는 enrollment 기능과 did 등록을 취소하는 disenrollment 기능 <br/>
이때, Reason을 등록할 수 있고 viewReason()을 통해 Reason을 볼 수 있다

다른 Contract에서 한국인임을 요청 할 수 있다<br/>
하지만 먼저 해당 Contract가 Whitelist에 등록이 되어있어야 한다 <br/>
관리자는 addWhiteList(address)와 removeWhiteList(address)를 실행해서 Whitelist를 관리 할 수 있다

Functions
<ul>
    enrollment(address) : did 추가 (관리자만 가능) - 추가 할 id <br/>
    disenrollment(address , uint8) : did 제거 (관리자만 가능) - 제거 할 id, 제거 이유 <br/>
    addReason(string) : did 제거 이유 추가 (관리자만 가능) - 제거할 이유 <br/>
    viewReason() : did 제거 이유 list 보기 <br/>
    addWhiteList(address) : did 확인할 수 있는 contract address whitelist 추가 (관리자만 가능) - 유효한 contract 주소 <br/>
    removeWhiteList(address) : did 확인할 수 있는 contract address whitelist 제거 (관리자만 가능) - whiltelist 안의 contract 주소 <br/>
</ul>

<h2> petition_kor.sol - Petition </h2>

블록체인 기반의 국민청원 Contract

Functions
<ul>
    vote(uint256 _id) : 투표하기 (해당 청원에 투표하지 않은 did 유효한 사람만 가능) - 투표할 청원 id <br/>
    write(string, string, string[]) : 청원 작성하기 (did 유효한 사람만 가능) - 청원 제목, 청원 내용, 태그들list <br/>
    viewContent(_id) returns(struct Contents) : 해당 id의 내용 가져오기 - 청원 id - 제목, 내용, 투표수, 태그, 시작 시간, 유효성 여부, 답변 url return <br/>
    getContentsList(uint, uint ) returns(struct Contents[]) : 지정된 시작 id부터 끝 id까지 불러오기 - 시작 id, 끝 id - 제목, 투표수, 태그 넣은 list return <br/>
    getLastIndex() : 마지막 청원 index return <br/>
    reply(uint256, string) : 청원 답변 하기 (청원 관리자만 가능) - 청원 id, 답변 url <br/>
</ul>

