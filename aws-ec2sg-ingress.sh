## Dynamic IP insert bash script for AWS EC2 Security Group
```sh
#!/bin/bash

# DNS sorgusu yaparak hopto.org'un IP adresini bulma
target_ip=$(dig +short <DOMAIN>)
current_time=$(date +%s)

# Eğer IP adresi boşsa veya bulunamazsa hata mesajı yazdır ve çık
if [ -z "$target_ip" ]; then
    echo "Hedef IP adresi bulunamadı. Script sona eriyor."
    exit 1
fi

# IP adresini güvenlik grubuna ekleme
# original
security_group_id="<AWS_EC2_SECURITY_ID>"

# Ekleme işlemi
aws ec2 authorize-security-group-ingress --group-id "$security_group_id" --ip-permissions IpProtocol=-1,IpRanges="[{CidrIp=$target_ip/32,Description='CLI_$current_time'}]"

# Başarılı mesajı
echo "IP adresi başarıyla güvenlik grubuna eklendi: $target_ip"
```
