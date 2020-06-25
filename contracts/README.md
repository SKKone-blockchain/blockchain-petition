<h1> Contracts Usage </h1>

<h2> did_kor.sol - Administrator </h2>

enrollment(address) : did 추가 (관리자만 가능) - 제거할 id
disenrollment(address , uint8) : did 제거 (관리자만 가능) - 제거할 id, 제거 이유
addReason(string) : did 제거 이유 추가 (관리자만 가능) - 제거할 이유
viewReason() : did 제거 이유 list 보기
addWhiteList(address) : did 확인할 수 있는 contract address whitelist 추가 (관리자만 가능) - 유효한 contract 주소
removeWhiteList(address) : did 확인할 수 있는 contract address whitelist 제거 (관리자만 가능) - whiltelist 안의 contract 주소


<h2> petition_kor.sol - Petition </h2>
vote(uint256 _id) : 투표하기 (해당 청원에 투표하지 않은 did 유효한 사람만 가능) - 투표할 청원 id
write(string, string, string[]) : 청원 작성하기 (did 유효한 사람만 가능) - 청원 제목, 청원 내용, 태그들list
viewContent(_id) returns(struct Contents) : 해당 id의 내용 가져오기 - 청원 id - 제목, 내용, 투표수, 태그, 시작 시간, 유효성 여부, 답변 url return
getContentsList(uint, uint ) returns(struct Contents[]) : 지정된 시작 id부터 끝 id까지 불러오기 - 시작 id, 끝 id - 제목, 투표수, 태그 넣은 list return
getLastIndex() : 마지막 청원 index return
reply(uint256, string) : 청원 답변 하기 (청원 관리자만 가능) - 청원 id, 답변 url

