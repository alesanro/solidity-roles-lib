pragma solidity ^0.4.21;


import "../Roles2LibraryAdapter.sol";


contract StubRoles2LibraryAdapter is Roles2LibraryAdapter {

    function StubRoles2LibraryAdapter(address _roles2Library) Roles2LibraryAdapter(_roles2Library) public {

    }

    function getTest1()
    auth
    external 
    returns (uint)
    {
        return 256;
    }


    function getProtectedTest1()
    auth
    external
    returns (uint)
    {
        return this.getTest1();
    }
}
