pragma solidity >=0.4.21;


contract recurTx {
    address private ownerAddress;

    constructor(address currAddress) public{
        ownerAddress = currAddress;
    }

     function execFunct(address to, uint256 value, bytes memory data) external returns(bool, bytes memory) {
        require(msg.sender == ownerAddress);
        return to.call{value: value}(data);

    }
}

contract Recurring {
    address public owner;
    uint256 public userKey;
    mapping(address => address) public userAcct;
    mapping(uint256 => bytes32) public scheduledTxs;

    constructor () public {
        owner = msg.sender;
    }    

    /* @param numBlock: block or timestamp at which the transaction should be executed. 
    @param to: recipient of the transaction.
    @param value: Amount of Wei to send with the transaction.
    @param data: transaction data.
    @return uint256 userKey of the transaction
    */
    
    // Schedule transactions
    function schedule(uint256 numBlock, address to, uint256 value, bytes memory data) public returns (uint,address){
        userKey = userKey + 1;
        scheduledTxs[userKey] = keccak256(abi.encodePacked(numBlock, msg.sender, to, value, data));
        return (userKey,userAcct[msg.sender]);
    }

     // execute transactions
    function executeTx(uint256 numBlock, address from, address to, uint256 value, bytes memory data) external {
        require(msg.sender==owner);
        require(scheduledTxs[userKey]==keccak256(abi.encodePacked(numBlock, from, to, value, data)));
        recurTx execTx = recurTx(userAcct[from]);

        execTx.execFunct(to, value, data);
         
    }



}
