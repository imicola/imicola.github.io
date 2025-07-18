@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo === 开始部署笔记 ===

REM 首先处理个人图书馆的 git 提交
echo === 处理个人图书馆的 Git 提交 ===
cd /d "D:\曦\个人图书馆"

REM 检查 git 状态
git status | findstr /C:"nothing to commit" > nul
if %errorlevel% equ 0 (
    echo 个人图书馆没有需要提交的更改，跳过 Git 提交步骤
) else (
    REM 获取当前日期时间作为提交信息
    for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
    set "YYYY=!dt:~0,4!"
    set "MM=!dt:~4,2!"
    set "DD=!dt:~6,2!"
    set "HH=!dt:~8,2!"
    set "Min=!dt:~10,2!"
    set "commit_msg=笔记更新 !YYYY!-!MM!-!DD! !HH!:!Min!"
    
    REM 执行 git 提交
    echo 正在提交更改到 Git: "!commit_msg!"
    git add .
    git commit -m "!commit_msg!"
    echo Git 本地提交完成
)

REM 切换到博客目录并执行部署
echo.
echo === 部署博客 ===
echo 切换到博客目录并执行 npm run deploy...

cd /d "D:\曦\my-blog"
if %errorlevel% neq 0 (
    echo 错误: 无法切换到博客目录，请检查路径是否正确
    goto end
)

call npm run deploy
if %errorlevel% neq 0 (
    echo 错误: npm run deploy 命令执行失败
    goto end
)

echo.
echo === 部署完成 ===
echo 您的笔记和博客已成功部署！

:end
echo 按任意键退出...
pause > nul
endlocal
exit /b
:end
echo.
echo === 部署完成 ===
echo 您的笔记和博客已成功部署！
echo 按任意键退出...
pause > nul
endlocal
