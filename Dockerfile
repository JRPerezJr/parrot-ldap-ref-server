FROM parrotsec/core

RUN apt update --fix-missing; apt -y full-upgrade; apt -y install python3 git maven vim tmux;

COPY $PWD/jdk-8u181-linux-x64.tar.gz /usr/lib/jvm

RUN cd /usr/lib/jvm; tar -xzvf jdk-8u181-linux-x64.tar.gz; \
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_181/bin/java" 1; \
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_181/bin/javac" 1; \
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0_181/bin/javaws" 1; \
update-alternatives --set java /usr/lib/jvm/jdk1.8.0_181/bin/java; \
update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_181/bin/javac; \
update-alternatives --set javaws /usr/lib/jvm/jdk1.8.0_181/bin/javaws; java -version;

RUN cd; mkdir solar; cd solar; git clone https://github.com/mbechler/marshalsec;\
cd marshalsec; mvn clean package -DskipTests;\
cd ..; mkdir shell; cd shell; apt autoremove -y;

COPY $PWD/ldap_server.sh /

RUN chmod +x ldap_server.sh 

CMD ./ldap_server.sh