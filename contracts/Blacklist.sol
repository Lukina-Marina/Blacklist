// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import {IBlacklist} from "./IBlacklist.sol";

contract Blacklist is ERC20, Ownable, IBlacklist {
    mapping(address => bool) public isBlacklisted;

    constructor(string memory name_, string memory symbol_, address _owner, uint256 value) ERC20(name_, symbol_) Ownable(_owner) {
        _mint(_owner, value);
    }

    function decimals() public pure override returns (uint8) {
        return 10;
    }

    function addAddressToBlacklist(address _account) external onlyOwner {
        isBlacklisted[_account] = true;

        emit AccountAdded(_account);
    }

    function deleteAddressFromBlacklist(address _account) external onlyOwner {
        delete isBlacklisted[_account];

        emit AccountDeleted(_account);
    }

    function mint(address account, uint256 value) external onlyOwner {
        _mint(account, value);
    }

    function burn(address account, uint256 value) external onlyOwner {
        _burn(account, value);
    }

    function checkAddressInBlacklist(address _account) public view {
        if (isBlacklisted[_account]) {
            revert("Account is on blacklist!");
        }
    }

    function _update(address from, address to, uint256 value) internal override {
        if (to != address(0)) {
            checkAddressInBlacklist(from);
        }

        return super._update(from, to, value);
    }
}