// SPDX-License-Identifier: UNLICENSED
//pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/axelar.sol";


// deployed addresses: https://docs.axelar.dev/dev/build/contract-addresses/mainnet



contract axelarTest is Test {
    ExecutableSample public Sender;
    ExecutableSample public Receiver;
    address gateway_;
    address gasReceiver_;

    function setUp() public {
        gateway_ = 0x6f015F16De9fC8791b234eF68D486d2bF203FBA8; // Polygon
        gasReceiver_ = 0x2d5d7d31F671F86C782533cc367F14109a082712; // Polygon
        Sender = new ExecutableSample(gateway_,gasReceiver_);
        Receiver = new ExecutableSample(gateway_,gasReceiver_);
    }

    function testsetRemoteValue() public {
        string memory destinationChain = "Moonbeam";
        string memory destinationAddress = toAsciiString(address(Receiver));
        string memory value_  = "hello";
        Sender.setRemoteValue(destinationChain, destinationAddress, value_);
    }

function toAsciiString(address x) internal returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
        bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
        bytes1 hi = bytes1(uint8(b) / 16);
        bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
        s[2*i] = char(hi);
        s[2*i+1] = char(lo);            
    }
    return string(s);
}

function char(bytes1 b) internal returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
}
}
