/*
    Ropsten testing account addr
    0x10a5496B1161dFf2F93eD39b5a71dCDBB7d1f308
*/
const petition_kor_addr = '0x5De4151886bd7976f7441e5B854CeE1DBdc7eE0F'
const did_kor_addr = '0xa3e0592e34786316941bbb642d6624863C6A9e70'

let petition_contract
let did_contract

async function get_contracts(){
    // use metamask provider
    const provider = await new ethers.providers.Web3Provider(window.ethereum)
    
    var petition_abi = await (await fetch('/contracts/petition_kor.abi.json')).json()
    var did_abi = await (await fetch('/contracts/did_kor.abi.json')).json()
    
    petition_contract = await new ethers.Contract(petition_kor_addr, petition_abi, provider)
    did_contract = await new ethers.Contract(did_kor_addr, did_abi, provider)
}

function set_innerText(element_id, string){
    let element = document.getElementById(element_id)
    // if (element.tagName == 'P'){
    //     element.setAttribute('style', 'white-space: pre;')
    // }
    element.textContent = string
}

function get_content(content_id){
    petition_contract.functions.viewContent(content_id).then((result) => {

        let response = result[0]

        let content = {
            'title': response.title,
            'content': response.content,
            'tags': response.tags
        }
        
        console.log(content)
    })
}


window.onload = async function(){
    // connect to blockchain provider and get contract object
    get_contracts()

}

