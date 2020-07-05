/*
    Ropsten testing account addr
    0x10a5496B1161dFf2F93eD39b5a71dCDBB7d1f308
*/
const petition_kor_addr = '0xF51444ddCAa9829C366b6ad66289988bE0Cfa347'
const did_kor_addr = '0xa3e0592e34786316941bbb642d6624863C6A9e70'

let petition_contract
let did_contract
let signed_petition_contract
let signed_did_contract

let list_length = 5

async function get_contracts(){
    // use metamask provider
    const provider = await new ethers.providers.Web3Provider(window.ethereum)
    const signer = provider.getSigner()
    
    var petition_abi = await (await fetch('/contracts/petition_kor.abi.json')).json()
    var did_abi = await (await fetch('/contracts/did_kor.abi.json')).json()
    
    petition_contract = await new ethers.Contract(petition_kor_addr, petition_abi, provider)
    did_contract = await new ethers.Contract(did_kor_addr, did_abi, provider)

    signed_petition_contract = petition_contract.connect(signer)
    signed_did_contract = did_contract.connect(signer)
}

function set_innerText(element_id, string){
    let element = document.getElementById(element_id)
    // if (element.tagName == 'P'){
    //     element.setAttribute('style', 'white-space: pre;')
    // }
    element.textContent = string
}

function get_petition(content_id){
    petition_contract.functions.viewContent(content_id).then((result) => {

        let response = result[0]

        let petition = {
            'title': response.title,
            'content': response.content,
            'tags': response.tags,
            'is_replied': response.isreplied,
            'timestamp': parseInt(response.starttime)
        }
        
        console.log(petition)
    })
}

function get_petition_last_index(){
    return new Promise(function(resolve, reject) {
        petition_contract.functions.getLastIndex().then((result) =>{
            let response = result[0]
    
            let last_index = parseInt(response._hex)
    
            // return last_index
            resolve(last_index)
        })
    })
}

function get_petition_list(start_index, end_index){
    return new Promise(function(resolve, reject){
        petition_contract.functions.getContentsList(start_index, end_index).then((result) =>{
            let response = result[0]
    
            // return array of petitions
            resolve(response)
        })
    })
}

async function upload_petition(){
    let title = document.getElementById('title').value
    let content = document.getElementById('content').value
    let tags = document.getElementById('tags').value.split(';')

    signed_petition_contract.write(title, content, tags).then((result) =>{
        console.log(result)
    })
}


window.onload = async function(){
    // connect to blockchain provider and get contract object
    await get_contracts()

    // for metamask deprecated feature warning
    ethereum.autoRefreshOnNetworkChange = false
    // activate metamask to get account access
    await window.ethereum.enable()

}

function add_petition_table(title, tags, vote_count, petition_index){
    console.log(title, tags, vote_count, petition_index)

    /*
        Find list table and insert petition to 1st child
        !!NOT!! append child
    */
}

function draw_petition_list(petitions, start_index){

    for (let petition of petitions){
        let title = petition.title
        let tags = petition.tags
        let vote_count = parseInt(petition.vote._hex)

        add_petition_table(title, tags, vote_count, start_index++)
    }
}

async function draw_latest_petition_list(){
    let last_index = await get_petition_last_index()
    if (last_index == 0){   // No petitions exist
        return
    }
    let start_index = last_index - list_length
    if (start_index < 0){
        start_index = 0
    }

    let petitions = await get_petition_list(start_index, last_index)

    /*
        Clear current petition list
    */

    draw_petition_list(petitions, start_index)
}


function invalid_addr_alert(){
    alert('Invalid address input')
}


function register_did(){
    let addr = document.getElementById('did-register-value').value

    if (!isAddress(addr)){
        invalid_addr_alert()
        return
    }

    signed_did_contract.enrollment(addr).then((result) => {
        console.log(result)
    })
}

function unregister_did(){
    let addr = document.getElementById('did-unregister-addr-value').value
    let reason_id = parseInt(document.getElementById('did-unregister-reason-value').value)

    if (!isAddress(addr)){
        invalid_addr_alert()
        return
    }

    signed_did_contract.disenrollment(addr, reason_id).then((result) => {
        console.log(result)
    })
}

function register_whitelist(){
    let addr = document.getElementById('whitelist-register-value').value

    if (!isAddress(addr)){
        invalid_addr_alert()
        return
    }

    signed_did_contract.addWhitelist(addr).then((result) => {
        console.log(result)
    })
}

function unregister_whitelist(){
    let addr = document.getElementById('whitelist-unregister-value').value

    if (!isAddress(addr)){
        invalid_addr_alert()
        return
    }

    signed_did_contract.removeWhitelist(addr).then((result) => {
        console.log(result)
    })
}