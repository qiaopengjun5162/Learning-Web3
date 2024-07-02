"""
@Project  : OpenSpace-S3-code
@Author   : QiaoPengjun
@Time     : 2024/7/2 15:49
@Software : PyCharm
@File     : pow.py
"""
import hashlib
import time


def proof_of_work(nickname, leading_zeros):
    """
    实践 POW， 编写程序（编程语言不限）用自己的昵称 + nonce，不断修改nonce 进行 sha256 Hash 运算：

    直到满足 4 个 0 开头的哈希值，打印出花费的时间、Hash 的内容及Hash值。
    再次运算直到满足 5 个 0 开头的哈希值，打印出花费的时间、Hash 的内容及Hash值。

    https://decert.me/challenge/45779e03-7905-469e-822e-3ec3746d9ece
    https://docs.google.com/spreadsheets/d/1P2d1OwoBNjNgAaYQBTHYygCOPT1yxkMlvUYwzvaE11s/edit?gid=991661407#gid=991661407
    :param nickname: 你的昵称
    :param leading_zeros: 要求哈希值前零的数量
    :return:
    """
    nonce = 0
    prefix = '0' * leading_zeros
    start_time = time.time()

    while True:
        text = f"{nickname}{nonce}"
        hash_result = hashlib.sha256(text.encode()).hexdigest()
        if hash_result.startswith(prefix):
            end_time = time.time()
            print(f"Hash with {leading_zeros} leading zeros found!")
            print(f"Time taken: {end_time - start_time:.6f} seconds")
            print(f"Nonce: {nonce}")
            print(f"Hash: {hash_result}\n")
            break
        nonce += 1


# 替换为你的昵称
nickname = "qiaopengjun5162"

# 找到前4个字符为0的哈希值
proof_of_work(nickname, 4)

# 找到前5个字符为0的哈希值
proof_of_work(nickname, 5)

"""
运行结果：

Hash with 4 leading zeros found!
Time taken: 0.020332 seconds
Nonce: 47718
Hash: 0000e4d046f0ef5a68a7b3b51d833fe612a36d2da99a02336a1e735f9c639d70

Hash with 5 leading zeros found!
Time taken: 0.212729 seconds
Nonce: 513088
Hash: 000009dfcd180b71089f290b7c6230ecf0bcd3e176a28f5331e37ca64fe57e26


                    满足 4 个 0 开头                                                      满足 5 个 0 开头
花费的时间            0.020332                                                            0.212729  
Hash 的内容          qiaopengjun516247718                                                qiaopengjun5162513088
Hash值              0000e4d046f0ef5a68a7b3b51d833fe612a36d2da99a02336a1e735f9c639d70    000009dfcd180b71089f290b7c6230ecf0bcd3e176a28f5331e37ca64fe57e26
"""