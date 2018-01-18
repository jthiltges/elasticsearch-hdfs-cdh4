#!/bin/bash

set -ex

cd /builddir/elasticsearch
git checkout v5.6.6

# Switch to Hadoop 2.0 (CDH4)
patch -p1 < /builddir/hdfs-2.0.patch

# Build the plugin
cd plugins/repository-hdfs
gradle updateSHAs
gradle assemble

# Build complete
echo "Build complete"
ls /builddir/elasticsearch/plugins/repository-hdfs/build/distributions/repository-hdfs-*.zip
