// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.0;

library String {

    function concat(string memory _x, string memory _y) pure internal returns (string memory) {
        bytes memory _xBytes = bytes(_x);
        bytes memory _yBytes = bytes(_y);
        
        string memory _tmpValue = new string(_xBytes.length + _yBytes.length);
        bytes memory _newValue = bytes(_tmpValue);
        
        uint i;
        uint j;
        
        for(i=0;i<_xBytes.length;i++) {
            _newValue[j++] = _xBytes[i];
        }
        
        for(i=0;i<_yBytes.length;i++) {
            _newValue[j++] = _yBytes[i];
        }
        
        return string(_newValue);
    }
}