#!/bin/bash -e

apt-get install libjansi-java

echo "============== Installing scala-2.9.3 ================"
cd /tmp && wget www.scala-lang.org/files/archive/scala-2.9.3.deb && sudo dpkg -i scala-2.9.3.deb && rm -f scala-2.9.3.deb;

echo "============== Installing scala-2.10.4 ================"
cd /tmp && wget www.scala-lang.org/files/archive/scala-2.10.4.deb && sudo dpkg -i scala-2.10.4.deb && rm -f scala-2.10.4.deb;

echo "============== Installing scala-2.11.0 ================"
cd /tmp && wget www.scala-lang.org/files/archive/scala-2.11.0 && sudo dpkg -i scala-2.11.0 && rm -f scala-2.11.0;

echo "================= Installing sbt-0.13.2 =================="
cd /tmp && wget http://dl.bintray.com/sbt/debian/sbt-0.13.2.deb && sudo dpkg -i sbt-0.13.2.deb && rm -f sbt-0.13.2.deb;

sudo apt-get update