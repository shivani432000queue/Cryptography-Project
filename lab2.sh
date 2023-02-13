#!/usr/bin/bash





if [ $1 == "-e" ]; then
	
        openssl pkeyutl -derive -inkey $3 -peerkey $2 -out secret1.bin # Creating the shared key  
        echo "Creating Shared Key"  
        openssl rand -hex 32 > symkey	# Creating the session key
        echo "Creating Session Key" 
        openssl enc -pbkdf2 -aes-256-cbc -in $4 -out plain.txt.enc -pass file:symkey	# Encrypting the plain text file with the session key
        echo "Encrypting the plain text file"
        #openssl dgst -sha256 plain.txt.enc 	
        openssl dgst -sha256 -sign $3 -out signature.sig plain.txt.enc	# Signing the encrypted file with the sender's private key
        openssl enc -pbkdf2 -aes-256-cbc -in symkey -out symkey.enc -pass file:secret1.bin	# Encrypting the session key with shared key
        zip -m $5 symkey.enc signature.sig plain.txt.enc	# Zipping the signature, encrypted session key and encrypted plain text file
        rm secret1.bin
        
elif [ $1 == "-d" ]; then	
	
	unzip $4 # Unzipping the folder
	echo "Unzipping $4...."
        openssl dgst -sha256 -verify $3 -signature signature.sig plain.txt.enc	
        openssl pkeyutl -derive -inkey $2 -peerkey $3 -out secret2.bin	# creating the shared key
        echo "Creating Shared Key" 
        openssl enc -aes-256-cbc -pbkdf2 -d -in symkey.enc -out symkey -pass file:secret2.bin	# Decrypting the session key
        echo " Decrypting the session key"
        openssl enc -aes-256-cbc -pbkdf2 -d -in plain.txt.enc -out $5 -pass file:symkey	# Decrypting the plain text file
        echo "Decrypting the plain text file"
        rm secret2.bin symkey.enc symkey plain.txt.enc $4.zip
else
	echo "<< Error pokharkar.s : Incorrect Syntax>>" # Error Handling
	echo "Command for encrypting and signing a file: ./lab2.sh -e <receiver_pub_key> <sender_priv_key> <plaintext> <encrypted_file>"

	echo "Command for decrypting and verifying the signature of a file: ./lab2.sh -d <receiver_priv_key> <sender_pub_key> <encrypted_file> <decrypted_file>"
        
fi



