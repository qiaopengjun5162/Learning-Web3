"""
@Project  : OpenSpace-S3-code
@Author   : QiaoPengjun
@Time     : 2024/7/2 16:39
@Software : PyCharm
@File     : rsa_pow.py
"""
import base64
from Crypto.PublicKey import RSA
from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA256

"""
实践非对称加密 RSA（编程语言不限）：

先生成一个公私钥对
用私钥对符合 POW 4个开头的哈希值的 “昵称 + nonce” 进行私钥签名
用公钥验证
"""


# 生成RSA公私钥对
def generate_rsa_keypair():
    key = RSA.generate(2048)
    private_key = key.export_key()
    public_key = key.publickey().export_key()
    return private_key, public_key


# 使用私钥对消息进行签名
def sign_with_private_key(private_key, message):
    key = RSA.import_key(private_key)
    h = SHA256.new(message.encode())
    signature = pkcs1_15.new(key).sign(h)
    return base64.b64encode(signature).decode('utf-8')


# 使用公钥验证签名
def verify_with_public_key(public_key, message, signature):
    rsa_key = RSA.import_key(public_key)
    h = SHA256.new(message.encode())
    try:
        pkcs1_15.new(rsa_key).verify(h, base64.b64decode(signature))
        return True
    except (ValueError, TypeError):
        return False


message = "qiaopengjun516247718"

# 生成公私钥对
private_key, public_key = generate_rsa_keypair()
print("Private Key:\n", private_key.decode())
print("Public Key:\n", public_key.decode())

# 使用私钥签名
Signature = sign_with_private_key(private_key, message)
print("Signature:\n", Signature)
#  YBne1iHnw2ywRyXZjVz9epS4npzKikvJIceHPr2QWZr11WNcCrKc0h7dj8Vli3dn50/a8hnWx/3QkrddjE0ZwD8L7XBdskVUxcujMVVL6WOZ+WUQNC7b5i3wNtJgnLEBcDA+2Ooij++RM6/IF3INY73Zxh5IykPEE+Dsq/ztCXHl8f5UBVesfQ33bJ/u0ZgwWxSswTsRIO762HwzxI6Cv2klwoytH6+NpYTUyZxlnQGoMhMUCdb4OVuc2pdEbAtGDN3rGAWuUSaM6Zzy2i7dFH3SI15dJEdLTCMfaknu2I+FniFBGcNGhTAkduSJj9MkIP5xCeGYW2v71wU9lyfvEw==

# 使用公钥验证
is_valid = verify_with_public_key(public_key, message, Signature)
print("Signature valid:", is_valid)
# Signature valid: True


# def rsa_sign(private_key, sign_str):
#     message = sign_str.encode('UTF-8')
#     signature = private_key.sign(data=message, padding=PKCS1v15(), algorithm=SHA256())
#     sign = b64encode(signature).decode('UTF-8').replace('\n', '')
#     return sign


# def rsa_sign(sign_str, private_key):
#         """
#         计算签名
#         :param sign_str:
#         :param private_key:
#         :return:
#         """
#         private_key_bytes = base64.b64decode(private_key)
#         pri_key = RSA.importKey(private_key_bytes)
#         signer = PKCS1_v1_5.new(pri_key, )
#         hash_obj = SHA256.new(sign_str.encode('utf-8'))
#         signature = base64.b64encode(signer.sign(hash_obj))
#         return signature.decode('utf8')
