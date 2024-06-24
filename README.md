# Error Handling

This is a Solidity program that provides the functionality of minting, burning, and transferring tokens between addresses. It is backed up by error handling mechanisms in Solidity. This is my submission for the ETH + AVAX Proof: Intermediate EVM Course.

## Description

It is a program written in Solidity. It has the main functionality of managing tokens between addresses.

### Program Functions

```javascript

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

```

The mint function takes an address and a value represented by an unsigned integer. That value is the amount of tokens to amount.

The burn function also takes both an address and value, however the value is the amount of tokens to burn.

Both of these functions modify the balance of an address.

Finally, the transfer function takes in two (2) addresses: sender, receiver; and a value. It transfers tokens between addresses.

## Authors

Andre A. Aquino 

