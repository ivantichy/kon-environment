FROM debian:jessie

RUN useradd -u 1200 postgres && useradd -u 1099 dummyuser

RUN apt-get -y update && \
apt-get -y install wget nano git postgresql

RUN  mkdir /home/dbbackup && cp -r /var/lib/postgresql/9.4/main /home/dbbackup/

RUN cd / && wget https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.1.4-jira-7.1.4-x64.bin

RUN chmod a+x atlassian-jira-software-7.1.4-jira-7.1.4-x64.bin

COPY ./installjira /installjira

RUN cd / && ./atlassian-jira-software-7.1.4-jira-7.1.4-x64.bin < ./installjira

#RUN rm /atlassian-jira-software-7.1.4-jira-7.1.4-x64.bin

VOLUME /var/lib/postgresql/9.4/main /var/atlassian/jira-app /var/atlassian/jira-home /var/hostdir

EXPOSE 8080
EXPOSE 8443

CMD [ "bash" ]
