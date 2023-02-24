// SPDX-License-Identifier: MIT
// Copied and Modified from Tornado Cash
// https://tornado.cash

pragma solidity ^0.7.0;

import "./ERC20Ajax.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract cAjax is ERC20Ajax {
  address public immutable governance = "proxy_contract address of governance"; // TODO: Change this
  IERC20 public immutable comp;

  constructor(
    IERC20 _comp,
    IVerifier _verifier,
    IHasher _hasher,
    uint256 _denomination,
    uint32 _merkleTreeHeight,
    IERC20 _token
  ) ERC20Ajax(_verifier, _hasher, _denomination, _merkleTreeHeight, _token) {
    require(address(_comp) != address(0), "Invalid COMP token address");
    comp = _comp;
  }

  /// @dev Moves earned yield of the COMP token to the nevellus governance contract
  /// To make it work you might need to call `comptroller.claimComp(cPoolAddress)` first
  function claimComp() external {
    comp.transfer(governance, comp.balanceOf(address(this)));
  }
}
