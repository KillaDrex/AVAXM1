// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.17 and less than 0.9.0
pragma solidity ^0.8.17;

contract Error {
    // create mapping of address to balance
    mapping(address => uint) public balances;

    // mint tokens for an address - require
    function mint(address _address, uint _value) external payable {
        require(_value > 0, "Value must be greater than 0");
        
        balances[_address] += _value;
    }

    // burn tokens from an address - assert
    function burn(address _address, uint _value) external payable {
        assert(balances[_address] >= _value);
        balances[_address] -= _value;
    }

    // transfer tokens from one address to another - revert
    function transfer(address _address, address _receiver, uint _value) external payable {
        if (balances[_address] <= _value) {
            revert("Sender doesn't have enough tokens");
        }

        // don't allow 0 token transfers
        assert(_value > 0);

        balances[_address] -= _value;
        balances[_receiver] += _value;
    }
}