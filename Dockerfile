FROM ubuntu:14.04

RUN apt-get -y update
RUN apt-get -y install git vim software-properties-common
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-get -y update
RUN apt-get -y install ansible
