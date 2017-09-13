pragma solidity ^0.4.11;

import "Ownable.sol";
import "Destructible.sol";

/**
* @title LegacySmartContract
* @dev Smart contract used to managed Legacy features
* This version shares tokens to differents addresses
*/
contract LegacySmartContract is Ownable, Destructible {

    address public _holderWalletAddress;
    address public _legacyWalletAddress;
    address public _devWalletAddress;
       
    function LegacySmartContract() {
    }

        /** 
    * @dev Distribute tokens send by user smart contract (when user credits his account)
    * Send 5% to the Legacy wallet
    * Send 5% to the holder wallet
    * Send 85% to the holder wallet
    * This smart contract keept 5%
    */
    function distributeTokens() public payable {
        _legacyWalletAddress.transfer(msg.value*5/100);
        _holderWalletAddress.transfer(msg.value*5/100);
        _devWalletAddress.transfer(msg.value*85/100);
    } 

    /**
    * @dev Used to set blockchain addresses
    * @param holderWalletAddress The address of the holder wallet.
    * @param legacyWalletAddress The address of the legacy wallet.
    * @param devWalletAddress The address of the legacy dev team wallet.
    */     
    function setAddress(address holderWalletAddress, address legacyWalletAddress, address devWalletAddress) onlyOwner {
        _holderWalletAddress = holderWalletAddress;
        _legacyWalletAddress = legacyWalletAddress;
        _devWalletAddress = devWalletAddress;
    }

    /**
    * @dev Used to get holder wallet blockchain address
    * @return holderWalletAddress The address of the holder wallet.
    */     
    function getHolderWalletAddress() onlyOwner constant returns (address) {
        return _holderWalletAddress;
    }
    /**
    * @dev Used to get legacy dev wallet blockchain addresse
    * @return devWalletAddress The address of the dev wallet.
    */     
    function getDevWalletAddress() onlyOwner constant returns (address) {
        return _devWalletAddress;
    }
        
    /**
    * @dev Used to get Legacy wallet blockchain address
    * @return legacyWalletAddress The address of the Legacy wallet.
    */     
    function getLegacyWalletAddress() onlyOwner constant returns (address) {
        return _legacyWalletAddress;
    }

    /** 
    * @dev To withdraw balance of the smart contract if needed
    */
    function withdraw(uint amount) public onlyOwner {
        if (this.balance >= amount) {
            msg.sender.transfer(amount);
        }
    } 
}