// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

import "./Workshop.sol";

contract ServiceTransaction is Workshop {
    enum serviceStatus {PAID, UNPAID}
    struct ServiceStruct {
        uint transactionDate;
        string description;
        string vehicleNumber;
        uint serviceFee;
        serviceStatus status;
        address payable serviceOwner;
    }
    mapping(string => ServiceStruct) public serviceHistory;
    event serviceEvent(string code);

    modifier validTransactionUnpaid(string memory code) {
        bool isValid = false;
        if(bytes(serviceHistory[code].description).length > 0){
            if(serviceHistory[code].status == serviceStatus.UNPAID){
                isValid = true;
            }
        }
        require(isValid, "Your transaction code is invalid, please check your transaction code again");
        _;
    }
    modifier validFee(string memory code) {
        require(serviceHistory[code].serviceFee == msg.value, "Service fee does not match.");
        _;
    }

    function createService(string memory description, string memory vehicleNumber, uint serviceFee) public isWorkshopOwner {
        string memory key = generate("SRV");
        serviceHistory[key] = ServiceStruct(block.timestamp, description, vehicleNumber, serviceFee, serviceStatus.UNPAID, msg.sender);
        emit serviceEvent(key);
    }

    function payService(string memory code) public payable validTransactionUnpaid(code) validFee(code){
        serviceHistory[code].status = serviceStatus.PAID;
        uint ownerFee = msg.value / 100;
        serviceHistory[code].serviceOwner.transfer(msg.value - ownerFee);
        owner.transfer(ownerFee);
    }
}