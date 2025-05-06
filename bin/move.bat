@echo off
:: ========== 配置参数 ==========
:: 服务端资源目录
set SERVER_RESOURCES=E:\workspace\xxx\boot-java\src\main\resources

:: 前端构建输出目录
set DIST_DIR=E:\workspace\xxx\boot-ui\dist

:: ========== 操作执行 ==========
:: 删除旧文件
del /f /q "%SERVER_RESOURCES%\templates\index.html"
rd /s /q "%SERVER_RESOURCES%\static\assets"

:: 复制新文件
copy /y "%DIST_DIR%\index.html" "%SERVER_RESOURCES%\templates\"
xcopy /e /y "%DIST_DIR%\assets\*" "%SERVER_RESOURCES%\static\assets\"

echo 操作已完成
pause