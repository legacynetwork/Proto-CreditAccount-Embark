pragma solidity ^0.4.11;

import "Ownable.sol";

/**
* @title Destructible
* @dev Base contract that can be destroyed by owner. All funds in contract will be sent to the owner.
*/
contract Destructible is Ownable {

    function Destructible() payable { } 

    /**
    * @dev Transfers the current balance to the owner and terminates the contract. 
    */
    function destroy() onlyOwner {
        selfdestruct(owner);
    }

    /**
    * @dev Transfers the current balance to the _recipient and terminates the contract.
    * @param _recipient The address to transfercurrent balance.
    */
    function destroyAndSend(address _recipient) onlyOwner {
        selfdestruct(_recipient);
    }
}