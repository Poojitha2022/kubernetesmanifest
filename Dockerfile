FROM ubuntu:latest
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz .
RUN tar xvfz apache*.tar.gz 
RUN mv apache-tomcat-9.0.76/* /opt/tomcat/.
RUN apt update -y
RUN apt install default-jre -y
RUN java -version
EXPOSE 8080
