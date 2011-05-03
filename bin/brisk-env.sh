#!/bin/sh


if [ -z $BRISK_HOME ]; then
    abspath=$(cd ${0%/*} && echo $PWD)
    export BRISK_HOME=`dirname "$abspath"`
fi

#
# Set the logging root
#
if [ -z $BRISK_LOG_ROOT ]; then
    export BRISK_LOG_ROOT=$BRISK_HOME/logs
fi


#
# Initialize cassandra env
#
export CASSANDRA_HOME=$BRISK_HOME/resources/cassandra
export CASSANDRA_BIN=$CASSANDRA_HOME/bin

. $CASSANDRA_BIN/cassandra.in.sh
 

#
# Add brisk jars
#
for jar in $BRISK_HOME/build/brisk*.jar; do
    export CLASSPATH=$CLASSPATH:$jar
done

for jar in $BRISK_HOME/lib/brisk*.jar; do
    export CLASSPATH=$CLASSPATH:$jar
done


#
#Add hive cassandra driver
#
for jar in $BRISK_HOME/resources/hive/lib/hive-cassandra*.jar; do
    export CLASSPATH=$CLASSPATH:$jar
done


#
# Initialize Hadoop env
#
export HADOOP_CLASSPATH=$CLASSPATH

#hadoop requires absolute home
export HADOOP_HOME=$BRISK_HOME/resources/hadoop
export HADOOP_BIN=$HADOOP_HOME/bin
export HADOOP_LOG_DIR=$BRISK_LOG_ROOT/hadoop



#export PIG_HOME=
#export PIG_CLASSPATH=$HADOOP_HOME/conf:$CLASSPATH


#
# Initialize Hive env
#
export HIVE_HOME=$BRISK_HOME/resources/hive
export HIVE_BIN=$HIVE_HOME/bin

