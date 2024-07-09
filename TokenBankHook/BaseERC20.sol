// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.9/contracts/utils/introspection/IERC1820Registry.sol
// https://github.com/vittominacori/erc1363-payable-token/blob/master/contracts/token/ERC1363/IERC1363Errors.sol

interface TokenRecipient {
    function tokensReceived(address from, uint256 amount) external returns (bool);
}

contract BaseERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public totalSupply;

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor() {
        // 设置代币的名称、符号、小数位数和总供应量
        name = "BaseERC20";
        symbol = "BERC20";
        decimals = 18;
        totalSupply = 100000000 * (10**uint256(decimals));

        // 初始供应量分配给合约部署者
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(
            balances[msg.sender] >= _value && _value > 0,
            "ERC20: transfer amount exceeds balance"
        );
        require(_to != address(0), "ERC20: transfer to the zero address");

        unchecked {
            balances[msg.sender] -= _value;
        }
        unchecked {
            balances[_to] += _value;
        }

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(
            balances[_from] >= _value && _value > 0,
            "ERC20: transfer amount exceeds balance"
        );
        require(_to != address(0), "ERC20: transfer to the zero address");

        require(
            allowances[_from][msg.sender] >= _value,
            "ERC20: transfer amount exceeds allowance"
        );

        unchecked {
            balances[_from] -= _value;
        }
        unchecked {
            balances[_to] += _value;
        }
        unchecked {
            allowances[_from][msg.sender] -= _value;
        }

        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        require(_spender != address(0), "ERC20: approve to the zero address");
        allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return allowances[_owner][_spender];
    }

    function transferWithCallback(address recipient, uint256 amount)
        external
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        if (isContract(recipient)) {
            bool rv = TokenRecipient(recipient).tokensReceived(
                msg.sender,
                amount
            );
            require(rv, "No tokensReceived");
        }
        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 value
    ) internal {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(
            balances[from] >= value,
            "ERC20: transfer amount exceeds balance"
        );

        balances[from] -= value;
        balances[to] += value;
        emit Transfer(from, to, value);
    }

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}
