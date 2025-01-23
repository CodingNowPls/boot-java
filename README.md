基于[metaee-boot](https://gitee.com/metaee/metaee-boot)
* 感谢metaee-boot作者
* 感谢 [RuoYi-Vue](https://gitee.com/y_project/RuoYi-Vue)
* 感谢 [FlowLong](https://gitee.com/aizuda/flowlong)
## 主要改进：
1. common细化
2. 依赖优化
3. 前后端可合并打包
4. redis缓存可选，默认使用local本地
5. 权限框架更改为sa-token
6. 集成mybatisplus-plus
7. mybatis-plus-join
8. 可使用springboot 瘦包
9. 后续应会同步若依更新（如果有时间的话） 同步ruoyi 日期： 2023-4-9 13:20
10. 考虑新增租户模块
11. 考虑添加工作流模块
12. 考虑添加动态表单模块
13. 考虑加入AI功能
14. 已经升级到springboot3 ，在springboot3分支上
15. 已经集成flowlong后端
 



## springboot 前后端合并打包
1. 前端dist打包以后，覆盖resources下的templates文件夹跟static文件夹

## springboot 瘦包 打包使用
1. 替换boot-admin包下的pom.xml文件
~~~
<build>
        <plugins>
            <!-- 打thin瘦包-->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>${springboot.version}</version>
                <configuration>
                    <layout>ZIP</layout>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.3.0</version>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>com.boot.BootApplication</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
            <!--打瘦包是将依赖的jar全部放到lib目录-->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-dependency-plugin</artifactId>
                <version>3.3.0</version>
                <executions>
                    <execution>
                        <phase>prepare-package</phase>
                        <goals>
                            <goal>copy-dependencies</goal>
                        </goals>
                        <configuration>
                            <!-- 将依赖放到target/lib目录下 -->
                            <outputDirectory>target/lib</outputDirectory>
                        </configuration>
                    </execution>
                </executions>
            </plugin>


            <!--assembly 将lib目录，demo.jar, config，bin文件等组合成一个发布包-->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-assembly-plugin</artifactId>
                <version>3.4.2</version>
                <configuration>
                    <!--   这个是assembly 所在位置；${basedir}是指项目的的根路径  -->
                    <descriptors>
                        <descriptor>${basedir}/assembly.xml
                        </descriptor>
                    </descriptors>
                    <!--打包解压后的目录名；${project.artifactId}是指：项目的artifactId-->
                    <finalName>${project.artifactId}</finalName>
                    <!-- zip包文件名不加上assembly.xml中配置的id属性值 -->
                    <appendAssemblyId>false</appendAssemblyId>
                    <!-- 打包压缩包位置-->
                    <outputDirectory>${project.build.directory}/release</outputDirectory>
                    <!-- 打包编码 -->
                    <encoding>UTF-8</encoding>
                </configuration>
                <executions>
                    <execution><!-- 配置执行器 -->
                        <id>make-assembly</id>
                        <!-- 绑定到package生命周期阶段上 -->
                        <phase>package</phase>
                        <goals>
                            <!-- 只运行一次 -->
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
        <finalName>${project.artifactId}</finalName>

    </build>

~~~

2. 在boot-admin模块的根目录（与pom.xml平级）新增assembly.xml文件
~~~
<?xml version="1.0" encoding="utf-8"?>
<assembly xmlns="http://maven.apache.org/ASSEMBLY/2.1.1"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/ASSEMBLY/2.1.1 http://maven.apache.org/xsd/assembly-2.1.1.xsd">
    <id>assembly</id>
    <formats>
        <format>dir</format>
    </formats>
    <includeBaseDirectory>false</includeBaseDirectory>

    <fileSets>
        <!-- Resources configuration -->
        <fileSet>
            <lineEnding>unix</lineEnding>
            <directory>${project.basedir}/src/main/resources</directory>
            <outputDirectory>.</outputDirectory>
            <includes>
                <include>*.properties</include>
                <include>*.yml</include>
                <include>*.xml</include>
            </includes>
        </fileSet>

        <!-- Static and templates -->
        <fileSet>
            <lineEnding>unix</lineEnding>
            <directory>${project.basedir}/src/main/resources</directory>
            <outputDirectory>.</outputDirectory>
            <includes>
                <include>static/**</include>
                <include>templates/**</include>
                <include>mybatis/**</include>
            </includes>
        </fileSet>

        <!-- 启动脚本 -->
        <fileSet>
            <lineEnding>unix</lineEnding>
            <directory>${project.basedir}/build/bin</directory>
            <outputDirectory>./bin</outputDirectory>
            <fileMode>0755</fileMode>
        </fileSet>

        <!-- 把项目自己编译出来的 jar 文件，打包进 zip 文件的根目录 -->
        <fileSet>
            <directory>${project.build.directory}/lib</directory>
            <outputDirectory>./lib</outputDirectory>
            <includes>
                <include>*.jar</include>
            </includes>
        </fileSet>

        <!-- 执行的主 jar 文件 -->
        <fileSet>
            <directory>${project.build.directory}</directory>
            <outputDirectory>./</outputDirectory>
            <includes>
                <include>*.jar</include>
            </includes>
        </fileSet>
    </fileSets>
</assembly>

~~~
## thin包启动命令
~~~
set JAVA_HOME=D:\program\Java\jdk\jdk-21.0.2
set PATH=%JAVA_HOME%\bin;%PATH%

java -Xms128m -Xmx256m -cp "boot-admin.jar;lib/*" -Dspring.config.location=application.yml,application-dev.yml com.boot.BootApplication

pause
~~~
 
 