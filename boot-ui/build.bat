@echo off
chcp 65001


%~d0
cd %~dp0



if exist "src\main\resources\webjars" (
    echo 删除webjars下的文件...
    del /q /f "src\main\resources\webjars\*"
    rem 如果要删除子目录也加上下面这行：
    for /d %%D in ("src\main\resources\webjars\*") do rd /s /q "%%D"
)


echo 执行打包web网页......

call npm run build:prod


::echo 拷贝dist文件到webjars中


::xcopy /e /y dist\* src\main\resources\webjars\

call mvn clean

call mvn package

:: 暂时先注释
::call move.bat

pause
