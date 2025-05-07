#!/bin/bash

# 应用名称（用于日志和 PID 文件）
APP_NAME="boot-java"
JAR_NAME="boot-java.jar"

# Java 环境配置（根据实际路径修改）
JAVA_HOME="/mnt/d/program/Java/jdk/openjdk-11/jdk-11"
JAVA="$JAVA_HOME/bin/java"

# 日志目录与 PID 文件路径
LOG_DIR="/var/log/boot-java"
PID_FILE="/var/run/${APP_NAME}.pid"
LOG_FILE="$LOG_DIR/app.log"

# JVM 参数
JVM_OPTS="-Xms128m -Xmx256m"
CLASSPATH="lib/*:$JAR_NAME"

# Spring 配置文件位置
SPRING_CONFIG="--spring.config.location=application.yml,application-prod.yml"

# 检查是否已运行
check_pid() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if ps -p $PID > /dev/null 2>&1; then
            return 0
        else
            rm -f "$PID_FILE"
        fi
    fi
    return 1
}

# 启动应用
start() {
    check_pid
    if [ $? -eq 0 ]; then
        echo "$APP_NAME 正在运行 (PID: $(cat $PID_FILE))"
        return
    fi

    echo "正在启动 $APP_NAME..."
    mkdir -p "$LOG_DIR"
    nohup $JAVA $JVM_OPTS -cp "$CLASSPATH" com.howe.App $SPRING_CONFIG > "$LOG_FILE" 2>&1 &
    echo $! > "$PID_FILE"
    echo "$APP_NAME 已启动 (PID: $!)"
}

# 停止应用
stop() {
    check_pid
    if [ $? -ne 0 ]; then
        echo "$APP_NAME 未运行"
        return
    fi

    echo "正在停止 $APP_NAME (PID: $PID)..."
    kill $PID && rm -f "$PID_FILE"
    echo "$APP_NAME 已停止"
}

# 重启应用
restart() {
    stop
    sleep 2
    start
}

# 主逻辑处理
ACTION="$1"
if [ -z "$ACTION" ]; then
    ACTION="start"
fi

case "$ACTION" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo "用法: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0


