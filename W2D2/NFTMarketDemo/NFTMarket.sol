// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/interfaces/IERC1363Receiver.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

contract Market is ERC165, IERC721Receiver, IERC1363Receiver {
    IERC20 public erc20;
    IERC721 public erc721;

    bytes4 internal constant MAGIC_ON_ERC721_RECEIVED = 0x150b7a02;

    struct Order {
        address seller;
        uint256 tokenId;
        uint256 price;
    }

    mapping(uint256 => Order) public orderOfId; // token id to order
    Order[] public orders;
    mapping(uint256 => uint256) public idToOrderIndex; // token id to index in orders

    event Deal(address seller, address buyer, uint256 tokenId, uint256 price);
    event NewOrder(address seller, uint256 tokenId, uint256 price);
    event PriceChanged(
        address seller,
        uint256 tokenId,
        uint256 previousPrice,
        uint256 price
    );
    event OrderCancelled(address seller, uint256 tokenId);

    constructor(address _erc20, address _erc721) {
        require(_erc20 != address(0), "zero address");
        require(_erc721 != address(0), "zero address");
        erc20 = IERC20(_erc20);
        erc721 = IERC721(_erc721);
    }

    function buy(uint256 _tokenId) external {
        address seller = orderOfId[_tokenId].seller;
        address buyer = msg.sender;
        uint256 price = orderOfId[_tokenId].price;

        require(seller != buyer, "seller and buyer are the same");
        require(price > 0, "price is zero");

        require(erc20.transferFrom(buyer, seller, price), "transfer failed");
        erc721.safeTransferFrom(address(this), buyer, _tokenId);

        //  remove order
        removeOrder(_tokenId);
        emit Deal(seller, buyer, _tokenId, price);
    }

    function _buyNFT(
        address buyer,
        uint256 _tokenId,
        uint256 value
    ) internal {
        uint256 price = orderOfId[_tokenId].price;
        address seller = orderOfId[_tokenId].seller;
        require(seller != address(0), "NFT not listed");
        require(price > 0, "price is zero");
        require(value >= price, "Insufficient payment");

        // 转移 ERC20 代币
        require(
            erc20.transferFrom(buyer, seller, price),
            "Token transfer failed"
        );

        // 如果支付金额超过价格，退回多余的代币
        if (value > price) {
            require(
                erc20.transfer(buyer, value - price),
                "transfer price failed"
            );
        }
        // 转移 NFT
        erc721.safeTransferFrom(address(this), buyer, _tokenId);
        removeOrder(_tokenId);
        emit Deal(seller, buyer, _tokenId, price);
    }

    function cancelOrder(uint256 _tokenId) external {
        address seller = orderOfId[_tokenId].seller;
        require(seller == msg.sender, "not the seller");
        erc721.safeTransferFrom(address(this), seller, _tokenId);
        //  remove order
        removeOrder(_tokenId);
        emit OrderCancelled(seller, _tokenId);
    }

    function changePrice(uint256 _tokenId, uint256 _price) external {
        address seller = orderOfId[_tokenId].seller;
        require(seller == msg.sender, "not the seller");
        require(_price > 0, "price is zero");
        uint256 previousPrice = orderOfId[_tokenId].price;
        orderOfId[_tokenId].price = _price;

        Order storage order = orders[idToOrderIndex[_tokenId]];
        order.price = _price;
        emit PriceChanged(seller, _tokenId, previousPrice, _price);
    }

    function isListed(uint256 _tokenId) public view returns (bool) {
        return orderOfId[_tokenId].seller != address(0);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4) {
        // require(msg.sender == address(erc721), "invalid sender");
        require(
            erc721.ownerOf(tokenId) == address(this),
            "not owned by this contract"
        );
        uint256 price = toUint256(data, 0);
        require(price > 0, "price is zero");
        // 上架
        orders.push(Order(from, tokenId, price));
        orderOfId[tokenId] = Order(from, tokenId, price);
        idToOrderIndex[tokenId] = orders.length - 1;
        emit NewOrder(from, tokenId, price);

        return this.onERC721Received.selector;
    }

    function removeOrder(uint256 _tokenId) internal {
        // 把index 和 最后一个元素进行调换，然后把index pop出去
        uint256 index = idToOrderIndex[_tokenId];
        uint256 lastIndex = orders.length - 1;
        if (index != lastIndex) {
            Order storage lastOrder = orders[lastIndex];
            idToOrderIndex[lastOrder.tokenId] = index;
            orders[index] = lastOrder;
        }
        orders.pop();
        delete orderOfId[_tokenId];
        delete idToOrderIndex[_tokenId];
    }

    // https://stackoverflow.com/questions/63252057/how-to-use-bytestouint-function-in-solidity-the-one-with-assembly
    function toUint256(bytes memory _bytes, uint256 _start)
        public
        pure
        returns (uint256)
    {
        require(_start + 32 >= _start, "Market: toUint256_overflow");
        require(_bytes.length >= _start + 32, "Market: toUint256_outOfBounds");
        uint256 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x20), _start))
        }

        return tempUint;
    }

    function getOrderLength() external view returns (uint256) {
        return orders.length;
    }

    function getAllNFTs() external view returns (Order[] memory) {
        return orders;
    }

    function getMyNFTs() external view returns (Order[] memory) {
        uint256 length = orders.length;
        Order[] memory _orders = new Order[](length);
        uint256 count = 0;
        for (uint256 i = 0; i < length; i++) {
            // _orders[i] = orders[i];
            _orders[count] = orders[i];
            count++;
        }
        return _orders;
    }

    function list(uint256 _tokenId, uint256 _price) external {
        // 检查调用此函数的用户是否是指定 _tokenId 的 NFT 的所有者。如果不是，则抛出错误信息 "NFT not owned by you" 并中止交易。
        require(erc721.ownerOf(_tokenId) == msg.sender, "NFT not owned by you");
        // 检查 _price 是否大于 0。如果不是，则抛出错误信息 "price is zero" 并中止交易。
        require(_price > 0, "price is zero");
        // 检查 _tokenId 是否已被列出。如果已被列出，则抛出错误信息 "NFT already listed" 并中止交易。
        require(isListed(_tokenId) == false, "NFT already listed");

        // 将新的订单信息（包括市场合约地址、_tokenId 和 _price）添加到 orders 数组中。
        orders.push(Order(address(this), _tokenId, _price));
        // 将订单信息（包括市场合约地址、_tokenId 和 _price）存储在 orderOfId 映射中，以 _tokenId 为键。
        orderOfId[_tokenId] = Order(address(this), _tokenId, _price);
        // 将订单索引存储在 idToOrderIndex 映射中，以 _tokenId 为键，值为订单在 orders 数组中的索引（orders.length - 1）。
        idToOrderIndex[_tokenId] = orders.length - 1;

        // 发送 NFT 给 market contract
        erc721.transferFrom(msg.sender, address(this), _tokenId);
        // 触发 NewOrder 事件，记录市场合约地址、_tokenId 和 _price，以便监听合约事件的用户或应用程序能够知道新的订单已经被创建。
        emit NewOrder(address(this), _tokenId, _price);
    }

    function onTransferReceived(
        address,
        address from,
        uint256 value,
        bytes calldata data
    ) external override returns (bytes4) {
        require(msg.sender == address(erc20), "Invalid token contract");

        uint256 tokenId = abi.decode(data, (uint256));
        _buyNFT(from, tokenId, value);

        return this.onTransferReceived.selector;
    }
}
