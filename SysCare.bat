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
echo [3] Reparo de imagem do Windows (DISM)
echo [4] Limpeza de disco (cleanmgr)
echo [0] Exit

echo.
set /p opcao=ESCOLHA UMA OPCAO: 
echo.

if not exist %opcao% (
    echo Selecione uma opcao valida
    goto :fim
)

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

if "%opcao%"=="3" (
    echo Iniciando reparo de imagem do Windows com DISM...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    echo Reparo de imagem concluido.
)

if "%opcao%"=="4" (
    echo Abrindo utilitario de limpeza de disco...
    cleanmgr
    echo.
    echo Limpeza de disco finalizada.
)


:fim
pause
cls
goto :menu
