// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

import "./String.sol";

contract KeyGenerator {
    string public lates_key;
    uint sequence;

    constructor(){
        sequence = 1;
    }

    function generate(string memory prefix) public returns (string memory) {
        string memory key = String.concat(String.concat(prefix, "-"), uint2str(sequence));
        sequence++;
        lates_key = key;
        return key;
    }

    function uint2str(uint _i) internal pure returns (string memory str){
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}