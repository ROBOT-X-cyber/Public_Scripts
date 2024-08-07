```bash
sudo npm install -g npm

sudo npm install broken-link-checker -g

blc -h

blc https://www.example.com -ro -i > broken-links-test.txt

cat broken-links-test.txt | grep "BROKEN"
```
