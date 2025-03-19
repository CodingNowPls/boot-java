#!/bin/bash
# 设置终端标题为 "boot-java"
printf "\033]0;boot-java\007"
# 设置JAVA_HOME环境变量
export JAVA_HOME=/path/to/your/jdk-21.0.2
export PATH=$JAVA_HOME/bin:$PATH

# 运行Java应用程序
java -Xms128m -Xmx256m -cp "boot-admin.jar:lib/*" -Dspring.config.location=application.yml,application-dev.yml com.boot.BootApplication

# 暂停脚本执行（可选）
read -p "Press any key to continue..."