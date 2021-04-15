FROM centos:7

COPY sign_rpm.sh /usr/local/bin/sign_rpm.sh

RUN yum install -y epel-release
RUN yum install -y https://repo.ius.io/ius-release-el7.rpm
RUN yum install -y git224 git2u python2-pip python36 python36-devel openldap-devel mariadb-devel gcc rpm-build

COPY sqlite-autoconf-3350400.tar.gz /root/sqlite-autoconf-3350400.tar.gz
RUN cd /root ; tar xzf sqlite-autoconf-3350400.tar.gz
RUN cd /root/sqlite-autoconf-3350400 ; ./configure && make && make install 
#RUN curl -O http://www6.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/atomic-sqlite-sqlite-3.8.5-3.el7.art.x86_64.rpm
#RUN yum localinstall -y atomic-sqlite-sqlite-3.8.5-3.el7.art.x86_64.rpm
#RUN mv /lib64/libsqlite3.so.0.8.6{,-3.17}
#RUN cp /opt/atomic/atomic-sqlite/root/usr/lib64/libsqlite3.so.0.8.6 /lib64

RUN pip install git+http://git@github.com/jzylks/rpmvenv-centos.git
RUN pip3 install --upgrade pip
RUN pip3 install wheel flake8 flake8-dashboard coverage pytest pytest-django pytest-cov pipenv

RUN mkdir /data

ENV QA_SKIP_BUILD_ROOT=1
ENV PIP_CACHE_DIR=/data/.cache/pip
ENV LC_ALL=en_US.utf-8
ENV LANG=en_US.utf-8
ENV VIRTUAL_ENV=/data/venv
