#FROM registry-proxy.engineering.redhat.com/rh-osbs/ubi9:latest
FROM registry.redhat.io/rhel9/support-tools

LABEL com.redhat.component="support-tools-container"
LABEL name="rhel9/support-tools"
LABEL version="9.4"
LABEL maintainer="Red Hat, Inc."
LABEL usage="podman container runlabel RUN rhel9/support-tools"

LABEL run="podman run -it --name NAME --privileged --ipc=host --net=host --pid=host -e HOST=/host -e NAME=NAME -e IMAGE=IMAGE -v /run:/run -v /var/log:/var/log -v /etc/machine-id:/etc/machine-id -v /etc/localtime:/etc/localtime -v /:/host IMAGE"

#labels for container catalog
LABEL summary="A set of tools to analyze the host system."
LABEL description="The Red Hat Enterprise Linux Support Tools image contains tools to analyze the host system including sosreport and sos-collector"
LABEL io.k8s.description="The Red Hat Enterprise Linux Support Tools image contains tools to analyze the host system including sosreport and sos-collector"
LABEL io.k8s.display-name="Red Hat Enterprise Linux Support Tools"
LABEL io.openshift.tags="sosreport, support"
LABEL io.openshift.expose-services=""

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

RUN INSTALL_PKGS="bind-utils nmon sysstat strace ltrace blktrace lsof" && \
    yum -y install $INSTALL_PKGS && \
    rpm -V --nosize --nofiledigest --nomtime $INSTALL_PKGS && \
    yum clean all && \
    rm -rf /usr/local/man

CMD ["/usr/bin/bash"]
