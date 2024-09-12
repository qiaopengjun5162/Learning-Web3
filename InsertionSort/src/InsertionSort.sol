// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract InsertionSort {
    // 插入排序函数，输入为无序数组，返回排序后的数组
    function insertionSort(uint256[] memory array) public pure returns (uint256[] memory) {
        for (uint256 i = 1; i < array.length; i++) {
            uint256 key = array[i];
            int256 j = int256(i) - 1;

            // Move elements of array[0..i-1], that are greater than key,
            // to one position ahead of their current position.
            while (j >= 0 && array[uint256(j)] > key) {
                array[uint256(j + 1)] = array[uint256(j)];
                j--;
            }
            // Ensure j + 1 is not out of bounds
            array[uint256(j + 1)] = key;
        }
        return array;
    }
}
// 1. 从数组的第二个元素开始，将其视为一个待插入的元素。
// 2. 将待插入的元素与它之前的元素进行比较，如果之前的元素大于待插入的元素，则将之前的元素向后移动一位。
// 3. 重复步骤2，直到找到待插入的元素应该插入的位置。
// 4. 将待插入的元素插入到找到的位置。
// 5. 重复步骤1-4，直到整个数组排序完成。
