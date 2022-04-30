#!/bin/sh

# get into run script dir (resolve to absolute path)
SCRIPT_DIR=$(cd $(dirname $0) && pwd)    # This dir is where this script live.
echo "SCRIPT_DIR:$SCRIPT_DIR"
cd $SCRIPT_DIR

#JVM Home
# ---------------------
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export JAVA_HOME=../jdk1.8/

#Current OS LANG
#export LANG=zh_CN.GBK

#Adding JvmOptions
# ---------------------
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Dfile.encoding=utf-8 -Dsun.jnu.encoding=utf-8 -Duser.timezone=GMT+8 -Duser.language=zh -Duser.country=CN -Djava.net.preferIPv4Stack=true -Djava.util.logging.config.file=./lib/logging.properties -Djava.security.policy=./conf/java.policy -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=../logs "

#JVM Version Options
# ---------------------
# 1.7 JAVA_OPTS="-server -Xmx2g -Xms2g -XX:PermSize=256m -XX:MaxPermSize=256m -XX:SurvivorRatio=16 -XX:+UseParNewGC  -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+DoEscapeAnalysis -XX:+CMSClassUnloadingEnabled -XX:+UseCMSCompactAtFullCollection $JAVA_OPTS "
# 1.8 JAVA_OPTS="-server -Xmx2g -Xms2g -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m -XX:SurvivorRatio=16 -XX:+UseParNewGC  -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+DoEscapeAnalysis -XX:+CMSClassUnloadingEnabled $JAVA_OPTS "
# 虚拟机监控参数:"-Dcom.sun.management.jmxremote.port=9393 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
#调试:-Xdebug -Xrunjdwp:transport=dt_socket,address=6666,server=y,suspend=n
#增大netty watermark应对maybe write overflow异常：-Dbolt.netty.buffer.low.watermark=131072 -Dbolt.netty.buffer.high.watermark=262144（默认：-Dbolt.netty.buffer.low.watermark=32768 -Dbolt.netty.buffer.high.watermark=65536）
#打开GC日志：-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintTenuringDistribution -XX:+PrintHeapAtGC -XX:+PrintGCApplicationStoppedTime -XX:+PrintReferenceGC -Xloggc:../logs/gc-%t.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=100M


# Startup
# ---------------------
export JAVA_OPTS="-server -Xmx4g -Xms4g -XX:MetaspaceSize=1024m -XX:MaxMetaspaceSize=1024m -XX:SurvivorRatio=16 -XX:+UseParNewGC  -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+DoEscapeAnalysis -XX:+CMSClassUnloadingEnabled -Djava.awt.headless=true $JAVA_OPTS "
${JAVA_HOME}/bin/java $JAVA_OPTS  $* -jar ./bootstrap.jar -r -lib "./patch;./lib;./jdbc" StartUp
