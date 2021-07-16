pragma solidity >=0.4.21;
import './recurringTX.sol';

contract RecurringTx{
    function schedule(uint256 numBlock, address to, uint256 value, bytes memory data) public returns (uint,address);

}

// Main contract
contract MyContract{
    RecurringTx recTx;
    address addr; //= someAddressHere;
    uint256 timeToTx; // "insert time here - ex: 5 days"

    constructor() public {
        scheduleTx();
    }

    function scheduleTx() public {
        recTx = RecurringTx(addr);
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256('transferTasks()')));
        recTx.schedule(block.timestamp + timeToTx, address(this), 0, data);
    }

//function with tasks for transfer and actions to take when timer is up and then after call the function to reschedule again
    function transferTasks() public {
        //pay
        //notify
        scheduleTx();
    }


}

