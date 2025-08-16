@echo off
setlocal EnableExtensions EnableDelayedExpansion

:menu
echo ========================================
echo        FERRAMENTA PARA USO TECNICO
echo                 SYSCARE
echo        EXECUTE COMO ADMINISTRADOR!
echo ========================================

echo.
echo [1] Verificacao de arquivos do windows (SFC)
echo [2] Limpeza de arquivos temporarios
echo [0] Exit

echo.
set /p opcao=ESCOLHA UMA OPCAO: 
echo.

if %opcao% equ 0 (
    exit
)

if %opcao% equ 1 (
    echo AGUARDE...
    sfc /scannow
)

if "%opcao%"=="2" (
    echo Apagando arquivos temporarios... Aguarde.
    echo.

    set /a apagados=0

    for /r "%TEMP%" %%F in (*) do (
        del /f /q "%%F" >nul 2>&1
        if not exist "%%F" set /a apagados+=1
    )
    for /d %%D in ("%TEMP%\*") do rd /s /q "%%D" >nul 2>&1

    for /r "C:\Windows\Temp" %%F in (*) do (
        del /f /q "%%F" >nul 2>&1
        if not exist "%%F" set /a apagados+=1
    )
    for /d %%D in ("C:\Windows\Temp\*") do rd /s /q "%%D" >nul 2>&1

    echo.
    echo Arquivos apagados: !apagados!
    echo Concluido.
)

pause
cls
goto :menu
