FROM ubuntu:18.04
RUN apt update && apt install --yes rubygems build-essential ruby-full git perl wget vim curl openjdk-8-jdk
RUN gem install travis
RUN curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh
RUN java -version
# jabba install adopt-openj9@1.8.0-252 -o /jdk
# export JAVA_HOME=/jdk
# export PATH=$JAVA_HOME/bin:$PATH
RUN git config --global user.email "m.francia@unibo.it"
RUN git config --global user.name "w4bo"