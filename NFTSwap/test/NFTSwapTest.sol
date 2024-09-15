// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFTSwap} from "../src/NFTSwap.sol";
import {WTFApe} from "../src/WTFApe.sol";

contract CounterTest is Test {
    NFTSwap public nftswap;
    WTFApe public nft;

    Account owner = makeAccount("owner");
    Account alice = makeAccount("alice");
    Account bob = makeAccount("bob");
    string uri = "https://www.wtfape.com/ape.json";
    uint256 public price = 1 * 10 ** 18;
    uint256 public tokenId_0 = 0;
    uint256 public tokenId_1 = 1;

    function setUp() public {
        // 1.部署NFT合约
        nft = new WTFApe(owner.addr);
        // 2.部署NFTSwap合约
        nftswap = new NFTSwap();

        vm.startPrank(owner.addr);
        nft.safeMint(owner.addr, uri);
        nft.safeMint(owner.addr, uri);
        // 3. 将要上架的NFT授权给NFTSwap合约
        nft.approve(address(nftswap), 0);
        nft.approve(address(nftswap), 1);
        require(nft.ownerOf(0) == owner.addr, "ownerOf should be owner");
        vm.stopPrank();
    }

    function testNftBalance() public view {
        require(nft.ownerOf(0) == owner.addr, "ownerOf should be owner");
        require(nft.ownerOf(1) == owner.addr, "ownerOf should be owner");
        require(nft.balanceOf(owner.addr) == 2, "balanceOf should be 2");
    }

    function testListNft() public {
        vm.startPrank(owner.addr);
        // 4. 上架NFT
        nftswap.list(address(nft), tokenId_0, price);
        nftswap.list(address(nft), tokenId_1, price);

        // 5. 查看上架NFT的信息
        (address nftowner, uint256 listedPrice) = nftswap.nftList(address(nft), tokenId_0); // 查看上架的NFT
        // 验证查询到的信息是否正确
        assertEq(nftowner, owner.addr); // 验证NFT的owner 是否正确
        assertEq(listedPrice, price); // 验证上架价格是否正确
        vm.stopPrank();
    }

    function testUpdateNftPrice() public {
        vm.startPrank(owner.addr);
        nftswap.list(address(nft), tokenId_0, price);
        // 6. 更新NFT价格
        nftswap.update(address(nft), tokenId_0, price * 2);
        (address nftowner, uint256 listedPrice) = nftswap.nftList(address(nft), tokenId_0); // 查看上架的NFT
        // 验证查询到的信息是否正确
        assertEq(nftowner, owner.addr); // 验证NFT的owner 是否正确
        assertEq(listedPrice, price * 2); // 验证上架价格是否正确
        vm.stopPrank();
    }

    // revoke
    function testRevokeNft() public {
        vm.startPrank(owner.addr);
        nftswap.list(address(nft), tokenId_1, price);
        // 7. 下架NFT
        nftswap.revoke(address(nft), tokenId_1);
        (address nftowner, uint256 listedPrice) = nftswap.nftList(address(nft), tokenId_1); // 查看上架的NFT
        // 验证查询到的信息是否正确
        assertEq(nftowner, address(0)); // 验证NFT的owner 是否正确
        assertEq(listedPrice, 0); // 验证上架价格是否正确
        vm.stopPrank();
    }

    // purchase
    function testPurchaseNft() public {
        vm.startPrank(owner.addr);
        require(nft.ownerOf(tokenId_0) == owner.addr, "NFT owner is not correct");

        nftswap.list(address(nft), tokenId_0, price);
        (address nftowner, uint256 listedPrice) = nftswap.nftList(address(nft), tokenId_0); // 查看上架的NFT
        // 验证查询到的信息是否正确
        assertEq(nftowner, owner.addr); // 验证NFT的owner 是否正确
        assertEq(listedPrice, price); // 验证上架价格是否正确
        vm.stopPrank();
        // 8. 购买NFT
        vm.startPrank(alice.addr);
        vm.deal(alice.addr, price);
        nftswap.purchase{value: price}(address(nft), tokenId_0);
        require(nft.ownerOf(tokenId_0) == alice.addr, "NFT owner is not correct");
        (address nftowner2, uint256 listedPrice2) = nftswap.nftList(address(nft), tokenId_0);
        // 验证查询到的信息是否正确
        assertEq(nftowner2, address(0)); // 验证NFT的owner 是否正确
        assertEq(listedPrice2, 0); // 验证上架价格是否正确
        vm.stopPrank();
    }

    function testPurchaseNft2() public {
        vm.startPrank(owner.addr);
        require(nft.ownerOf(tokenId_0) == owner.addr, "NFT owner is not correct");

        nftswap.list(address(nft), tokenId_0, price);
        (address nftowner, uint256 listedPrice) = nftswap.nftList(address(nft), tokenId_0); // 查看上架的NFT
        // 验证查询到的信息是否正确
        assertEq(nftowner, owner.addr); // 验证NFT的owner 是否正确
        assertEq(listedPrice, price); // 验证上架价格是否正确
        vm.stopPrank();
        // 8. 购买NFT
        vm.startPrank(alice.addr);
        vm.deal(alice.addr, price * 2);
        nftswap.purchase{value: price * 2}(address(nft), tokenId_0);
        require(nft.ownerOf(tokenId_0) == alice.addr, "NFT owner is not correct");
        (address nftowner2, uint256 listedPrice2) = nftswap.nftList(address(nft), tokenId_0);
        // 验证查询到的信息是否正确
        assertEq(nftowner2, address(0)); // 验证NFT的owner 是否正确
        assertEq(listedPrice2, 0); // 验证上架价格是否正确
        vm.stopPrank();
    }
}
