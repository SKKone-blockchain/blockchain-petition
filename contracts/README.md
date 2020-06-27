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
    <table>
        <tr> 
            <th> function name (param) returns(return type) </th>
            <th> function description </th>
            <th> parameter description </th>
            <th> return value descripion</th>
        </tr>
        <tr>
            <td>
                enrollment (address)
            </td>
            <td>
                did 추가 (관리자만 가능)
            </td>
            <td>
                추가 할 id - wallet address
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                disenrollment (address , uint8)
            </td>
            <td>
                did 제거 (관리자만 가능)
            </td>
            <td>
                제거 할 id, 제거 이유
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                addReason (string)
            </td>
            <td>
                did 제거 이유 추가 (관리자만 가능)
            </td>
            <td>
                did 제거 이유
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                viewReason () returns(string[])
            </td>
            <td>
                did 제거 이유 보기
            </td>
            <td>
            </td>
            <td>
                did 제거 이유들
            </td>
        </tr>
        <tr>
            <td>
                addWhiteList (address)
            </td>
            <td>
                did 확인할 수 있는 contract address whitelist 추가 (관리자만 가능)
            </td>
            <td>
                유효한 contract 주소
            </td>
            <td>
            </td>
        </tr>
            <tr>
            <td>
                removeWhiteList (address)
            </td>
            <td>
                did 확인할 수 있는 contract address whitelist 제거 (관리자만 가능)
            </td>
            <td>
                whiltelist 안의 contract 주소
            </td>
            <td>
            </td>
        </tr>
    </table>
</ul>

<h2> petition_kor.sol - Petition </h2>

블록체인 기반의 국민청원 Contract

Functions
<ul>
    <table>
        <tr>
            <th> function name (param) returns(return type) </th>
            <th> function description </th>
            <th> parameter description </th>
            <th> return value descripion</th>
        </tr>
        <tr>
            <td> vote (uint256 _id)</td>
            <td> 투표하기 (해당 청원에 투표하지 않은 did 유효한 사람만 가능)</td>
            <td> 투표할 청원 id</td>
            <td> </td>
        </tr>
        <tr>
            <td> write (string, string, string[])</td>
            <td> 청원 작성하기 (did 유효한 사람만 가능)</td>
            <td> 청원 제목, 청원 내용, 태그들list</td>
            <td> </td>
        </tr>
        <tr>
            <td> viewContent (_id) returns(struct Contents) </td>
            <td> 해당 id의 내용 가져오기</td>
            <td> 청원 id</td>
            <td> 제목, 내용, 투표수, 태그, 시작 시간, 유효성 여부, 답변 url return</td>
        </tr>
        <tr>
            <td>getContentsList (uint, uint) returns(struct Contents[])</td>
            <td> 지정된 시작 id부터 끝 id까지 불러오기</td>
            <td> 시작 id, 끝 id</td>
            <td> 제목, 투표수, 태그 넣은 list return</td>
        </tr>
        <tr>
            <td>getLastIndex () returns uint</td>
            <td> 마지막 청원 index return</td>
            <td> </td>
            <td> 마지막 청원 index</td>
        </tr>
        <tr>
            <td>reply (uint256, string) </td>
            <td> 청원 답변 하기 (청원 관리자만 가능)</td>
            <td> 청원 id, 답변 url</td>
            <td> </td>
        </tr>
    </table>
</ul>

