// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/InsertionSort.sol";

contract InsertionSortTest is Test {
    InsertionSort public sorter;

    function setUp() public {
        sorter = new InsertionSort();
    }

    function testInsertionSortBasic() public view {
        uint256[] memory array = new uint256[](4);
        array[0] = 4;
        array[1] = 3;
        array[2] = 2;
        array[3] = 1;

        uint256[] memory sortedArray = sorter.insertionSort2(array);

        // 检查排序结果是否正确
        assertEq(sortedArray[0], 1);
        assertEq(sortedArray[1], 2);
        assertEq(sortedArray[2], 3);
        assertEq(sortedArray[3], 4);
    }

    function testInsertionSortAlreadySorted() public view {
        uint256[] memory array = new uint256[](4);
        array[0] = 1;
        array[1] = 2;
        array[2] = 3;
        array[3] = 4;

        uint256[] memory sortedArray = sorter.insertionSort(array);

        // 检查排序结果是否保持原样
        assertEq(sortedArray[0], 1);
        assertEq(sortedArray[1], 2);
        assertEq(sortedArray[2], 3);
        assertEq(sortedArray[3], 4);
    }

    function testInsertionSortWithDuplicates() public view {
        uint256[] memory array = new uint256[](5);
        array[0] = 3;
        array[1] = 1;
        array[2] = 2;
        array[3] = 3;
        array[4] = 1;

        // uint256[] memory sortedArray = sorter.insertionSort(array);
        uint256[] memory sortedArray = sorter.insertionSort2(array);

        // 检查排序结果
        assertEq(sortedArray[0], 1);
        assertEq(sortedArray[1], 1);
        assertEq(sortedArray[2], 2);
        assertEq(sortedArray[3], 3);
        assertEq(sortedArray[4], 3);
    }
}
