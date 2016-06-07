
#!/bin/bash
#author Ivan Tichy


#crontab
#0 4 5 * * /root/lecert.sh >> /var/log/lecert.log 2>&1

#Please modify these values according to your environment
certdir=/etc/letsencrypt/live/jira.ivantichy.cz/ #just replace the domain name after /live/
keytooldir=/opt/atlassian/jira/jre/bin/ #java keytool located in jre/bin
mydomain=jira.ivantichy.cz #put your domain name here
myemail=ivan.tichy@gmail.com #your email
networkdevice=venet0 #your network device  (run ifconfig to get the name)
keystoredir=/home/jira/.keystore #located in home dir of user that you Tomcat is running under - just replace jira with your user you use for Tomcat, see ps -ef to get user nam$

#the script itself:
cd /var/git/letsencrypt
git pull origin master
iptables -I INPUT -p tcp -m tcp --dport 9999 -j ACCEPT
iptables -t nat -I PREROUTING -i $networkdevice -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 9999

#./letsencrypt-auto certonly --standalone --test-cert --break-my-certs -d $mydomain --standalone-supported-challenges http-01 --http-01-port 9999 --renew-by-default --email $my$
./letsencrypt-auto certonly --standalone -d $mydomain --standalone-supported-challenges http-01 --http-01-port 9999 --renew-by-default --email $myemail --agree-tos

iptables -t nat -D PREROUTING -i $networkdevice -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 9999
iptables -D INPUT -p tcp -m tcp --dport 9999 -j ACCEPT

$keytooldir/keytool -delete -alias root -storepass changeit -keystore $keystoredir
$keytooldir/keytool -delete -alias tomcat -storepass changeit -keystore $keystoredir

openssl pkcs12 -export -in $certdir/fullchain.pem -inkey $certdir/privkey.pem -out $certdir/cert_and_key.p12 -name tomcat -CAfile $certdir/chain.pem -caname root -password pass$

$keytooldir/keytool -importkeystore -srcstorepass aaa -deststorepass changeit -destkeypass changeit -srckeystore $certdir/cert_and_key.p12 -srcstoretype PKCS12 -alias tomcat -k$
$keytooldir/keytool -import -trustcacerts -alias root -deststorepass changeit -file $certdir/chain.pem -noprompt -keystore $keystoredir


# restart your Tomcat server – mine is running JIRA
service jira stop
service jira start

