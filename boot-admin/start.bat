@echo off
title boot-java

set JAVA_HOME=D:\program\Java\jdk\jdk-21.0.2
set PATH=%JAVA_HOME%\bin;%PATH%

java -Xms128m -Xmx256m -cp "boot-admin.jar;lib/*" -Dspring.config.location=application.yml com.boot.BootApplication

pause