FROM centos:centos7

RUN yum install -y java-1.8.0-openjdk-headless \
                   java-1.8.0-openjdk-devel \
                   git \
                   patch \
                   unzip && \
    yum clean all

ENV GRADLE_VER 4.4.1
ENV HTTP_PROXY proxy.pki.hcc.unl.edu:3128
ENV JAVA_HOME  /usr/lib/jvm/java

RUN curl --location -O https://services.gradle.org/distributions/gradle-${GRADLE_VER}-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-${GRADLE_VER}-bin.zip && \
    rm gradle-${GRADLE_VER}-bin.zip && \
    cd /usr/bin && \
    ln -s /opt/gradle/gradle-${GRADLE_VER}/bin/gradle

RUN mkdir /builddir && cd /builddir && \
    git clone https://github.com/elastic/elasticsearch.git

COPY build.sh hdfs-2.0.patch /builddir/
