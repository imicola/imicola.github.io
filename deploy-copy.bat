@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo === ��ʼ����ʼ� ===

REM ���ȴ������ͼ��ݵ� git �ύ
echo === �������ͼ��ݵ� Git �ύ ===
cd /d "D:\��\����ͼ���"

REM ��� git ״̬
git status | findstr /C:"nothing to commit" > nul
if %errorlevel% equ 0 (
    echo ����ͼ���û����Ҫ�ύ�ĸ��ģ����� Git �ύ����
) else (
    REM ��ȡ��ǰ����ʱ����Ϊ�ύ��Ϣ
    for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
    set "YYYY=!dt:~0,4!"
    set "MM=!dt:~4,2!"
    set "DD=!dt:~6,2!"
    set "HH=!dt:~8,2!"
    set "Min=!dt:~10,2!"
    set "commit_msg=�ʼǸ��� !YYYY!-!MM!-!DD! !HH!:!Min!"
    
    REM ִ�� git �ύ
    echo �����ύ���ĵ� Git: "!commit_msg!"
    git add .
    git commit -m "!commit_msg!"
    echo Git �����ύ���
)

REM �л�������Ŀ¼��ִ�в���
echo.
echo === ���𲩿� ===
echo �л�������Ŀ¼��ִ�� npm run deploy...

cd /d "D:\��\my-blog"
if %errorlevel% neq 0 (
    echo ����: �޷��л�������Ŀ¼������·���Ƿ���ȷ
    goto end
)

call npm run deploy
if %errorlevel% neq 0 (
    echo ����: npm run deploy ����ִ��ʧ��
    goto end
)

echo.
echo === ������� ===
echo ���ıʼǺͲ����ѳɹ�����

:end
echo ��������˳�...
pause > nul
endlocal
exit /b
:end
echo.
echo === ������� ===
echo ���ıʼǺͲ����ѳɹ�����
echo ��������˳�...
pause > nul
endlocal
