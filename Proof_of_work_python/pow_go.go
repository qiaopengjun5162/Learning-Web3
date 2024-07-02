package main

import (
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"strings"
	"time"
)

func main() {
	nickname := "qiaopengjun5162" // 替换为你的昵称
	startTime := time.Now()
	findHashWithLeadingZeros(nickname, 4)
	endTime := time.Now()
	fmt.Printf("4 zeros: Time taken: %s\n", endTime.Sub(startTime))

	startTime = time.Now()
	findHashWithLeadingZeros(nickname, 5)
	endTime = time.Now()
	fmt.Printf("5 zeros: Time taken: %s\n", endTime.Sub(startTime))
}

func findHashWithLeadingZeros(nickname string, leadingZeros int) {
	prefix := strings.Repeat("0", leadingZeros)
	nonce := 0

	for {
		input := fmt.Sprintf("%s%d", nickname, nonce)
		hash := sha256.Sum256([]byte(input))
		hashStr := hex.EncodeToString(hash[:])

		if strings.HasPrefix(hashStr, prefix) {
			fmt.Printf("Found hash with %d leading zeros\n", leadingZeros)
			fmt.Printf("Nonce: %d\n", nonce)
			fmt.Printf("Input: %s\n", input)
			fmt.Printf("Hash: %s\n", hashStr)
			return
		}
		nonce++
	}
}
