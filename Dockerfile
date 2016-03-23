FROM centos:7
MAINTAINER "Upsilon Development Team"

ADD http://ci.teratan.net/repositories/pub/upsilon-node-rpm-el7/upsilon-node-rpm-el7.repo /etc/yum.repos.d/upsilon-node.repo
RUN yum install upsilon-node -y
ADD config.xml /etc/upsilon-node/config.xml

USER upsilon
ENTRYPOINT ["/usr/share/upsilon-node/bin/upsilon-node"]
