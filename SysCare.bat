@echo off
setlocal

:menu
echo ========================================
echo        FERRAMENTA PARA USO TECNICO
echo                 SYSCARE
echo        EXECUTE COMO ADMINISTRADOR!
echo ========================================

echo.
echo [1] Verificacao de arquivos do windows (SFC)
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

pause
cls
goto :menu
