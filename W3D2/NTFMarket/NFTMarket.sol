// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC20Permit.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Market is ReentrancyGuard {
    using ECDSA for bytes32;

    struct Listing {
        address seller;
        address nftContract;
        uint256 tokenId;
        uint256 price;
        bool isActive;
    }

    IERC20 public paymentToken;
    address public whitelistSigner;
    mapping(address => mapping(uint256 => Listing)) public listings;

    event NFTListed(
        address indexed seller,
        address indexed nftContract,
        uint256 indexed tokenId,
        uint256 price
    );

    event NFTPurchased(
        address indexed buyer,
        address indexed nftContract,
        uint256 indexed tokenId,
        uint256 price
    );

    constructor(address _paymentToken, address _whitelistSigner) {
        paymentToken = IERC20(_paymentToken);
        whitelistSigner = _whitelistSigner;
    }

    function list(
        address _nftContract,
        uint256 _tokenId,
        uint256 _price
    ) external {
        IERC721 nft = IERC721(_nftContract);
        require(nft.ownerOf(_tokenId) == msg.sender, "NFT not owned by you");
        require(
            nft.isApprovedForAll(msg.sender, address(this)),
            "Not approved for this contract"
        );
        listings[_nftContract][_tokenId] = Listing(
            msg.sender,
            _nftContract,
            _tokenId,
            _price,
            true
        );
        emit NFTListed(msg.sender, _nftContract, _tokenId, _price);
    }

    function buyNFT(
        address _nftContract,
        uint256 _tokenId
    ) external nonReentrant {
        Listing storage listing = listings[_nftContract][_tokenId];
        require(listing.price > 0, "NFT not listed for sale");
        require(listing.isActive, "NFT not active");

        IERC721 nft = IERC721(_nftContract);

        require(
            paymentToken.transferFrom(
                msg.sender,
                listing.seller,
                listing.price
            ),
            "payment failed"
        );
        nft.safeTransferFrom(listing.seller, msg.sender, _tokenId);
        listing.isActive = false;

        emit NFTPurchased(msg.sender, _nftContract, _tokenId, listing.price);
    }

    function permitBuy(
        address _nftContract,
        uint256 _tokenId,
        uint256 _price,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        bytes memory whitelistSignature
    ) external nonReentrant {
        Listing storage listing = listings[_nftContract][_tokenId];
        require(listing.price == _price, "Incorrect price");
        require(listing.isActive, "NFT not active");

        bytes32 hash = keccak256(abi.encodePacked(msg.sender));
        // 验证白名单签名，确保调用者是经过授权的白名单用户。
        require(
            hash.toEthSignedMessageHash().recover(whitelistSignature) ==
                whitelistSigner,
            "Invalid whitelist signature"
        );

        // 使用 IERC20Permit 的 permit 方法进行代币授权。
        paymentToken.permit(
            msg.sender,
            address(this),
            _price,
            deadline,
            v,
            r,
            s
        );
        // 完成代币转账和 NFT 转移。
        IERC721 nft = IERC721(_nftContract);

        require(
            paymentToken.transferFrom(
                msg.sender,
                listing.seller,
                listing.price
            ),
            "payment failed"
        );
        nft.safeTransferFrom(listing.seller, msg.sender, _tokenId);
        listing.isActive = false;

        emit NFTPurchased(msg.sender, _nftContract, _tokenId, listing.price);
    }
}
