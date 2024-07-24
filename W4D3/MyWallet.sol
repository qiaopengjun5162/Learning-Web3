// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

contract MyWallet {
    string public name;
    mapping(address => bool) private approved;
    address public owner;

    // https://github.com/Vectorized/solady/blob/main/src/auth/Ownable.sol#L124
    bytes32 internal constant _OWNER_SLOT =
        0xffffffffffffffffffffffffffffffffffffffffffffffffffffffff74873927;

    /// @dev `keccak256(bytes("OwnershipTransferred(address,address)"))`.
    uint256 private constant _OWNERSHIP_TRANSFERRED_EVENT_SIGNATURE =
        0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0;

    modifier auth() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor(string memory _name) {
        name = _name;
        owner = msg.sender;
    }

    function transferOwernship(address newOwner) public auth {
        require(newOwner != address(0), "New owner is the zero address");
        require(owner != newOwner, "New owner is the same as the old owner");
        // owner = _addr;
        // 使用内联汇编修改owner
        assembly {
            sstore(2, newOwner)
        }
    }

    // 辅助函数，用于查看owner的存储槽位置
    function getOwnerSlot() public pure returns (uint256) {
        uint256 slot;
        assembly {
            slot := owner.slot
        }
        return slot;
    }

    // https://www.rareskills.io/post/evm-solidity-storage-layout
    function readSlotOwner_bool() external view returns (bytes32 value) {
        assembly {
            value := sload(owner.slot) // will compile
        }
    }

    function transferOwnership(address newOwner) public payable virtual {
        /// @solidity memory-safe-assembly
        assembly {
            if iszero(shl(96, newOwner)) {
                mstore(0x00, 0x7448fbae) // `NewOwnerIsZeroAddress()`.
                revert(0x1c, 0x04)
            }
        }
        _setOwner(newOwner);
    }

    function _checkOwner() internal view virtual {
        /// @solidity memory-safe-assembly
        assembly {
            // If the caller is not the stored owner, revert.
            if iszero(eq(caller(), sload(_OWNER_SLOT))) {
                mstore(0x00, 0x82b42900) // `Unauthorized()`.
                revert(0x1c, 0x04)
            }
        }
    }

    function _guardInitializeOwner()
        internal
        pure
        virtual
        returns (bool guard)
    {}

    function _setOwner(address newOwner) internal virtual {
        if (_guardInitializeOwner()) {
            /// @solidity memory-safe-assembly
            assembly {
                let ownerSlot := _OWNER_SLOT
                // Clean the upper 96 bits.
                newOwner := shr(96, shl(96, newOwner))
                // Emit the {OwnershipTransferred} event.
                log3(
                    0,
                    0,
                    _OWNERSHIP_TRANSFERRED_EVENT_SIGNATURE,
                    sload(ownerSlot),
                    newOwner
                )
                // Store the new value.
                sstore(ownerSlot, or(newOwner, shl(255, iszero(newOwner))))
            }
        } else {
            /// @solidity memory-safe-assembly
            assembly {
                let ownerSlot := _OWNER_SLOT
                // Clean the upper 96 bits.
                newOwner := shr(96, shl(96, newOwner))
                // Emit the {OwnershipTransferred} event.
                log3(
                    0,
                    0,
                    _OWNERSHIP_TRANSFERRED_EVENT_SIGNATURE,
                    sload(ownerSlot),
                    newOwner
                )
                // Store the new value.
                sstore(ownerSlot, newOwner)
            }
        }
    }
}
