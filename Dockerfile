FROM centos:7
MAINTAINER "Upsilon Development Team"
ENTRYPOINT ["/usr/share/upsilon-node/bin/upsilon-node"]
ADD http://ci.teratan.net/repositories/pub/upsilon-node-rpm-el7/upsilon-node-rpm-el7.repo /etc/yum.repos.d/upsilon-node.repo
RUN yum install upsilon-node -y
