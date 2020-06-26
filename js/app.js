/*
    Ropsten testing account addr
    0x10a5496B1161dFf2F93eD39b5a71dCDBB7d1f308
*/
const petition_kor_addr = '0x5De4151886bd7976f7441e5B854CeE1DBdc7eE0F'
const did_kor_addr = '0xa3e0592e34786316941bbb642d6624863C6A9e70'

var petition_contract
var did_contract

async function get_contracts(){
    // use metamask provider
    const provider = await new ethers.providers.Web3Provider(window.ethereum)
    
    var petition_abi = await (await fetch('/contracts/petition_kor.abi.json')).json()
    var did_abi = await (await fetch('/contracts/did_kor.abi.json')).json()
    
    petition_contract = await new ethers.Contract(petition_kor_addr, petition_abi, provider)
    did_contract = await new ethers.Contract(did_kor_addr, did_abi, provider)
}

window.onload = function(){
    get_contracts()
}