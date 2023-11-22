FROM bitnami/percona-xtrabackup:8
USER root
RUN install_packages ncat
RUN install_packages default-mysql-client
