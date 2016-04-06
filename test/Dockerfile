FROM jenkins

USER root

RUN apt-get update -y && \
apt-get install fail2ban -y -q && \
apt-get install git -y -q && \
apt-get install sudo -y -q && \
apt-get install maven -y -q && \
apt-get install iptables -y -q && \
apt-get install openvpn -y -q && \
rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/java -m -s /bin/bash java

RUN echo "jenkins ALL=(java) NOPASSWD: /bin/bash" >> /etc/sudoers
RUN echo "jenkins ALL=(root) NOPASSWD: /bin/su - java" >> /etc/sudoers

RUN echo "nobody    ALL=(ALL:ALL) NOPASSWD: /sbin/route" >> /etc/sudoers
RUN echo "java    ALL=(ALL:ALL) NOPASSWD: /sbin/iptables, /sbin/iptables-save, /sbin/iptables-restore /etc/iptables/rules.v4.backup" >> /etc/sudoers

#RUN chown -R java:java /etc/openvpn/ && mkdir -p /etc/iptables/ && chown -R java:java /etc/iptables/

USER jenkins


