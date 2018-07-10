pragma solidity ^0.4.21;


contract StubStorageManager {
    function isAllowed(address, bytes32) public pure returns (bool) {
        return true;
    }
}
