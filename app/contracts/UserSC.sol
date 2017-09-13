pragma solidity ^0.4.11;

import "Ownable.sol";
import "Destructible.sol";
import "LegacySC.sol";

/**
* @title UserSmartContract
* @dev Smart contract used manage user account
*/
contract UserSmartContract is Ownable, Destructible {

    address public _userWalletAddress;
    address public _legacySmartContractAddress;
    address public _heirWalletAddress;
    uint public _intervalPoL;
    uint public _nextPoLTimestampExpire;

    // Constructor. Define interval (in secondes) for PoL checks (manually checks)
    function UserSmartContract(uint intervalPoL) {
        _intervalPoL = intervalPoL;
        _nextPoLTimestampExpire = now + _intervalPoL;
    }

    /**
    * @dev Methode used by the user to credit his account
    * Send 5% to the user wallet
    * Send 90% to the Legacy smart contract
    * This smart contract keept 5%
    */
    function creditAccount() public payable {
        if (msg.value > 0) {
            _userWalletAddress.transfer(msg.value*5/100);
            LegacySmartContract legacySmartContract = LegacySmartContract(_legacySmartContractAddress);
            legacySmartContract.distributeTokens.value(msg.value*90/100)();
        }
    } 

    /**
    * @dev PoL (Proof Of Life) methode. Simulate PoL message (plugins, Legacy App...)
    * This methode is used to prove that user is alive
    */
    function checkPoL(bool isAlive) {
        if (isAlive) {
            _nextPoLTimestampExpire = now + _intervalPoL;
        }
    }

    /**
    * @dev Execute PoL checks. If user is dead, balance of this smart contract is trafered to the heir wallet
    * This methode is used to simulate Oracle automate call
    */
    function processPoL() {
        if (now > _nextPoLTimestampExpire) {
            _heirWalletAddress.transfer(this.balance);
        }
    }

    /**
    * @dev Used to set blockchain addresses
    * @param userWalletAddress The address of the user wallet.
    * @param legacySmartContractAddress The address of the lagacy smart contract.
    * @param heirWalletAddress The address of the heir wallet.
    */    
    function setAddress(address userWalletAddress, address legacySmartContractAddress, address heirWalletAddress) onlyOwner {
        _userWalletAddress = userWalletAddress;
        _legacySmartContractAddress = legacySmartContractAddress;
        _heirWalletAddress = heirWalletAddress;
    }

    /**
    * @dev Used to get user wallet blockchain address
    * @return userWalletAddress The wallet address of the user.
    */     
    function getUserWalletAddress() onlyOwner constant returns (address) {
        return _userWalletAddress;
    }
    /**
    * @dev Used to get legacy smart contract blockchain addresse
    * @return legacySmartContractAddress The wallet address of the legacy smart contract.
    */     
    function getLegacySCAddress() onlyOwner constant returns (address) {
        return _legacySmartContractAddress;
    }
        
    /**
    * @dev Used to get heir wallet blockchain address
    * @return heirWalletAddress The wallet address of the heir.
    */     
    function getHeirWalletAddress() onlyOwner constant returns (address) {
        return _heirWalletAddress;
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