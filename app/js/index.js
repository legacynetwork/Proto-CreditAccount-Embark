/*globals $, SimpleStorage, document*/

var addToLog = function(id, txt) {
  $(id + " .logs").append("<br>" + txt);
};

// ===========================
// Blockchain example
// ===========================
$(document).ready(function() {

  $("#legacySetSCBlockchain button.set").click(function() {
    var holderWalletAddress = $("#legacySetSCBlockchain input.inputHolderWalletAddress").val();
    var legacyWalletAddress = $("#legacySetSCBlockchain input.inputDevWalletAddress").val();
    var devWalletAddress = $("#legacySetSCBlockchain input.inputLegacyWalletAddress").val();
    LegacySmartContract.setAddress(holderWalletAddress, legacyWalletAddress, devWalletAddress);
    addToLog("#legacyLogBlockchain", "LegacySmartContract.setAddress(" + holderWalletAddress + "," + legacyWalletAddress + "," + devWalletAddress + " )");
  });

  $("#userSetSCBlockchain button.set").click(function() {
    var userWalletAddress = $("#userSetSCBlockchain input.inputUserWalletAddress").val();
    var legacySCAddress = $("#userSetSCBlockchain input.inputLegacySCAddress").val();
    var heirWalletAddress = $("#userSetSCBlockchain input.inputHeirWalletAddress").val();
    UserSmartContract.setAddress(userWalletAddress, legacySCAddress, heirWalletAddress);
    addToLog("#legacyLogBlockchain", "UserSmartContract.setAddress(" + userWalletAddress + "," + legacySCAddress + "," + heirWalletAddress + " )");
  });

  $("#legacyGetSCBlockchain button.get").click(function() {
    LegacySmartContract.getHolderWalletAddress().then(function(value) {
      $("#legacyGetSCBlockchain .valueHolderWalletAddress").html(value);
    });
    addToLog("#legacyLogBlockchain", "LegacySmartContract.getDevWalletAddress()");
    LegacySmartContract.getDevWalletAddress().then(function(value) {
      $("#legacyGetSCBlockchain .valueDevWalletAddress").html(value);
    });
    addToLog("#legacyLogBlockchain", "LegacySmartContract.getLegacyWalletAddress()");
    LegacySmartContract.getLegacyWalletAddress().then(function(value) {
      $("#legacyGetSCBlockchain .valueLegacyWalletAddress").html(value);
    });
    addToLog("#legacyLogBlockchain", "LegacySmartContract.getLegacyWalletAddress()");
  });

  $("#userGetSCBlockchain button.get").click(function() {
    UserSmartContract.getUserWalletAddress().then(function(value) {
      $("#userGetSCBlockchain .valueUserWalletAddress").html(value);
    });
    addToLog("#legacyLogBlockchain", "UserSmartContract.getUserWalletAddress()");
    UserSmartContract.getLegacySCAddress().then(function(value) {
      $("#userGetSCBlockchain .valueLegacySCAddress").html(value);
    });
    addToLog("#legacyLogBlockchain", "UserSmartContract.getLegacySCAddress()");
    UserSmartContract.getHeirWalletAddress().then(function(value) {
      $("#userGetSCBlockchain .valueHeirWalletAddress").html(value);
    });
    addToLog("#legacyLogBlockchain", "UserSmartContract.getHeirWalletAddress()");
  });

});