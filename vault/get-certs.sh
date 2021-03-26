SECRET=$(vault write -format=json pki_int/issue/consul-client common_name=localhost ttl=768h)

FILE_NAME=$(uuidgen)

touch $FILE_NAME.key
touch $FILE_NAME.crt


echo $SECRET | jq -r '.data.certificate' > $FILE_NAME.crt
echo $SECRET | jq -r '.data.private_key' > $FILE_NAME.key

openssl pkcs12 -export -in $FILE_NAME.crt -inkey $FILE_NAME.key -out bundle.p12

rm $FILE_NAME.crt
rm $FILE_NAME.key
