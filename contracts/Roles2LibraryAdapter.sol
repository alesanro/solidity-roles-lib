/**
 * Copyright 2017–2018, LaborX PTY
 * Licensed under the AGPL Version 3 license.
 */

pragma solidity ^0.4.21;


interface Roles2LibraryInterface {
    function addUserRole(address _user, uint8 _role) external returns (uint);
    function canCall(address _src, address _code, bytes4 _sig) external view returns (bool);
}


contract Roles2LibraryAdapter {

    uint constant UNAUTHORIZED = 0;
    uint constant OK = 1;

    event AuthFailedError(address code, address sender, bytes4 sig);

    Roles2LibraryInterface internal roles2Library;

    modifier auth {
        if (!_isAuthorized(msg.sender, msg.sig)) {
            emit AuthFailedError(this, msg.sender, msg.sig);
            return;
        }
        _;
    }

    function Roles2LibraryAdapter(address _roles2Library) public {
        require(_roles2Library != 0x0);
        roles2Library = Roles2LibraryInterface(_roles2Library);
    }

    function setRoles2Library(Roles2LibraryInterface _roles2Library) 
    auth 
    external 
    returns (uint) 
    {
        roles2Library = _roles2Library;
        return OK;
    }

    function _isAuthorized(address _src, bytes4 _sig) 
    internal 
    view 
    returns (bool) 
    {
        if (_src == address(this)) {
            return true;
        }

        if (address(roles2Library) == 0x0) {
            return false;
        }

        return roles2Library.canCall(_src, this, _sig);
    }
}
