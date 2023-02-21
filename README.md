# Cryptography-Project
The Cryptography Project utilizes both Asymmetric and Symmetric cryptography for secure transmission of the message between two nodes to provide confidentiality . Additionally this project uses Diffie-Hellman key exchange for secret keys, hashing and digital signature for the purpose of integrity and non repudiation respectively.

The project includes bash script for encryption and decryption of the plain text message, it additionally includes public-private keys for the both the nodes for trial of the code.

Before executing the bash script, make sure the location of your bash is correctly entered in the code just after the shebang(#!).

Do not forget to give executional permissions to the bash script using chmod +x filename.sh

Finally for encryption of the plain text message use the followning syntax:

./filename.sh -e <receiver_pub_key> <sender_priv_key> <plaintext> <encrypted_file>

For decryption of the cipher text utilize the following syntax:

./filename.sh -d <receiver_priv_key> <sender_pub_key> <encrypted_file> <decrypted_file>


