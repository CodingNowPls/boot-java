@echo off
chcp 65001 >nul

:: ========== 配置参数 ==========
set "SERVER_LIB=E:\workspace\boot-java\lib"
set "JAR_FILE=E:\workspace\boot-ui-webjar\target\boot-ui-1.0.0.jar"

:: ========== 检查路径有效性 ==========
if not exist "%JAR_FILE%" (
    echo 错误：源 jar 文件不存在！路径为：
    echo %JAR_FILE%
    pause
    exit /b 1
)

:: 如果目标目录不存在，则创建它
if not exist "%SERVER_LIB%" (
    echo 警告：目标目录不存在，正在创建...
    mkdir "%SERVER_LIB%"
)

:: ========== 输出调试信息 ==========
echo 当前操作路径:
echo Server lib: %SERVER_LIB%
echo Jar file : %JAR_FILE%

:: 删除旧的 jar 文件（如果存在）
if exist "%SERVER_LIB%\boot-ui-1.0.0.jar" (
    echo 正在删除旧版本 jar 文件...
    del /f /q "%SERVER_LIB%\boot-ui-1.0.0.jar"
)

:: 复制新的 jar 文件过去（只需复制到目录即可）
echo 正在复制新 jar 文件到目标目录...
copy /y "%JAR_FILE%" "%SERVER_LIB%"

:: 检查是否复制成功
if errorlevel 1 (
    echo ERROR: 文件复制失败，请检查路径或权限。
) else (
    echo 操作已完成，文件已成功复制到：
    echo %SERVER_LIB%\boot-ui-1.0.0.jar
)

pause
