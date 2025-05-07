@echo off
:: ========== 配置参数 ==========
:: 服务端资源目录
set SERVER_RESOURCES=E:\workspace\xxx\boot-java\src\main\resources

:: 前端构建输出目录
set DIST_DIR=E:\workspace\xxx\boot-ui\dist

:: ========== 操作执行 ==========
:: 删除旧文件
rd /s /q "%SERVER_RESOURCES%\static"

:: 复制新文件
xcopy /e /y "%DIST_DIR%\*" "%SERVER_RESOURCES%\static\"

echo 操作已完成
pause