import sys
from Crypto.Cipher import AES
from binascii import b2a_hex, a2b_hex
 
class prpcrypt():
    def __init__(self, key):
        self.key = key
        self.mode = AES.MODE_CBC
     
    def encrypt(self, text):
        cryptor = AES.new(self.key, self.mode, self.key)
        length = 32
        count = len(text)
        add = length - (count % length)
        text = text + ('\0' * add)
        self.ciphertext = cryptor.encrypt(text)
        return b2a_hex(self.ciphertext)
     
    def decrypt(self, text):
        cryptor = AES.new(self.key, self.mode, self.key)
        plain_text = cryptor.decrypt(a2b_hex(text))
        return plain_text.rstrip('\0')
 
if __name__ == '__main__':
    pc = prpcrypt(raw_input("input api key"))  
    e = pc.encrypt(raw_input("input content"))
    d = pc.decrypt(e)                     
    print e, d
