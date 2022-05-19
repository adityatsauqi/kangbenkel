// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

import "./RandomString.sol";
import "./Ownable.sol";

contract Workshop is Ownable {
    
    struct workshopSturct {
        address workshopOwner;
        string workshopName;
    }
    mapping(string => workshopSturct) public workshopRegister;
    mapping(address => string) public workshopList;
    event registrationCode(string code, string workshopName);

    modifier isWorkshopOwner() {
        require(bytes(workshopList[msg.sender]).length > 0, "Your request cannot be fulfilled, please register yourself to become a partner workshop");
        _;
    }

    modifier registrationExist(string memory _code) {
        require(bytes(workshopRegister[_code].workshopName).length > 0, "Registration number not found");
        _;
    }

    function registerWorkshop(string memory workshopName) public {
        string memory key = RandomString.getKey();
        workshopRegister[key] = workshopSturct(msg.sender, workshopName);
        emit registrationCode(key, workshopName);
    }

    function activateWorkshop(string memory _code) public isOwner registrationExist(_code){
        workshopSturct memory _workshop = workshopRegister[_code];
        workshopList[_workshop.workshopOwner] = _workshop.workshopName;
        delete workshopRegister[_code];
    }

}