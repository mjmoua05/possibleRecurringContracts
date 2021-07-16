pragma solidity >=0.4.21;
import './recurringTX.sol';

contract RecurringTx{
    function schedule(uint256 numBlock, address to, uint256 value, bytes memory data) virtual public returns (uint,address);
}

// Main contract
contract MyContract{
    RecurringTx rTx;
    address addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; //= someAddressHere;
    uint256 timeToTx; // "insert time here - ex: 5 days"
    
    constructor() public{
        scheduleTx();
    }

    //function with tasks for transfer and actions to take when time period is up and then after call the function to reschedule again
    function transferTasks() public {
        //payFunction(); etc
        scheduleTx();
    }

    //Schedule transactions call
    function scheduleTx() public {
        rTx = RecurringTx(addr);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('transferTasks()')));
        rTx.schedule(block.timestamp + timeToTx, address(this), 0, data);
    }



}

