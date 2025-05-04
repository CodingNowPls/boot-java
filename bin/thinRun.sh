#!/bin/bash

# 设置 Java 环境变量（路径需根据实际安装位置修改）
export JAVA_HOME="/mnt/d/program/Java/jdk/openjdk-11/jdk-11"
export PATH="$JAVA_HOME/bin:$PATH"

# 运行 Java 应用（注意类路径分隔符改为冒号）
$JAVA_HOME/bin/java -Xms128m -Xmx256m \
  -cp "tao-li-server.jar:lib/*" \
  -Dspring.config.location="application.yml,application-dev.yml" \
  com.boot.BootApplication

# 等待用户按键（Linux 下的 pause 替代方案）
read -p "按任意键继续..."