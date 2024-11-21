// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IBlacklist is IERC20 {
    event AccountAdded(address _account);
    event AccountDeleted(address _account);

    function addAddressToBlacklist(address _account) external;

    function deleteAddressFromBlacklist(address _account) external;

    function checkAddressInBlacklist(address _account) external view;
}