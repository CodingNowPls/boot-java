set JAVA_HOME=D:\program\Java\jdk\openjdk-11\jdk-11
set PATH=%JAVA_HOME%\bin;%PATH%

java -Xms128m -Xmx256m -cp "boot-admin.jar;lib/*" -Dspring.config.location=application.yml,application-dev.yml com.boot.BootApplication

pause