import hashlib
from Crypto import Random
from Crypto.Cipher import AES
from base64 import b64encode, b64decode

class AESCipher(object):
    def __init__(self, key):
        self.block_size = AES.block_size
        self.key = hashlib.sha256(key.encode()).digest()

    def encrypt(self, plain_text):
        plain_text = self.__pad(plain_text)
        iv = Random.new().read(self.block_size)
        cipher = AES.new(self.key, AES.MODE_CBC, iv)
        encrypted_text = cipher.encrypt(plain_text.encode())
        return b64encode(iv + encrypted_text).decode("utf-8")

    def decrypt(self, encrypted_text, secret_key):
        # Check if the provided secret key matches the original key
        if hashlib.sha256(secret_key.encode()).digest() != self.key:
            return "Decryption failed (incorrect key)"
        try:
            encrypted_text = b64decode(encrypted_text)
            iv = encrypted_text[:self.block_size]
            cipher = AES.new(self.key, AES.MODE_CBC, iv)
            plain_text = cipher.decrypt(encrypted_text[self.block_size:]).decode("utf-8")
            return self.__unpad(plain_text)
        except (ValueError, KeyError, IndexError):
            return "Decryption failed (incorrect key)"

    def __pad(self, plain_text):
        number_of_bytes_to_pad = self.block_size - len(plain_text) % self.block_size
        ascii_string = chr(number_of_bytes_to_pad)
        padding_str = number_of_bytes_to_pad * ascii_string
        padded_plain_text = plain_text + padding_str
        return padded_plain_text

    @staticmethod
    def __unpad(plain_text):
        last_character = plain_text[len(plain_text) - 1:]
        return plain_text[:-ord(last_character)]

if __name__ == "__main__":
    # Prompt the user to enter the secret key
    encryption_key = input("Enter the secret key: ")

    # Create an instance of AESCipher with the provided key
    cipher = AESCipher(encryption_key)

    while True:
        # Prompt the user to enter the plaintext (must be 16 characters long)
        plaintext = input("Enter plaintext (16 characters): ")

        # Check if the plaintext length is exactly 16 characters
        if len(plaintext) != 16:
            print("Plaintext must be exactly 16 characters long.")
        else:
            break  # Exit the loop if valid input is provided

    # Encrypt the plaintext
    encrypted_text = cipher.encrypt(plaintext)

    # Print the encrypted text
    print("Encrypted text:", encrypted_text)

    while True:
        # Prompt the user to enter the encrypted text for decryption
        encrypted_input = input("Enter the encrypted text: ")

        # Prompt the user to enter the secret key for decryption
        secret_key = input("Enter the secret key for decryption: ")

        # Decrypt the ciphertext back to plaintext
        decrypted_text = cipher.decrypt(encrypted_input, secret_key)

        # Check if decryption was successful
        if decrypted_text != "Decryption failed (incorrect key)":
            print("Decrypted text:", decrypted_text)
            if decrypted_text == plaintext:
                print("Decryption matched the original plaintext.")
            else:
                print("Decryption did not match the original plaintext.")
            break
        else:
            print("Decryption failed. Incorrect key entered.")
