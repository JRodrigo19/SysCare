@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

:menu
echo ========================================
echo        FERRAMENTA PARA USO TÉCNICO
echo                 SYSCARE
echo        EXECUTE COMO ADMINISTRADOR!
echo ========================================

echo.
echo [1] Verificação de arquivos do windows (SFC)
echo [2] Limpeza de arquivos temporários
echo [3] Reparo de imagem do Windows (DISM)
echo [4] Limpeza de disco (cleanmgr)
echo [5] Checagem de disco (chkdsk)
echo [6] Ping Google
echo [7] Resetar configurações de rede
echo [8] Resetar Spooler de Impressão
echo [9] Atualizar políticas de grupo
echo [10] Mass Grave
echo [11] Systeminfo
echo [0] Exit

set "validas=0 1 2 3 4 5 6 7 8 9 10 11 20"

echo.
set "opcao=20"
set /p opcao=ESCOLHA UMA OPÇÃO: 
echo.

echo !validas! | findstr /c:"%opcao%" >nul
if errorlevel 1 (
    echo Opção inválida!
    goto :fim
)

if "%opcao%"=="20" (
    echo Número não definido!
    pause
    goto :fim
)

if "%opcao%"=="0" (
    exit
)

if "%opcao%"=="1" (
    echo AGUARDE...
    sfc /scannow
    echo.
    echo Verificação concluida
    goto :fim
)

if "%opcao%"=="2" (
    echo Apagando arquivos temporários... Aguarde.
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
    goto :fim
)

if "%opcao%"=="3" (
    echo Iniciando reparo de imagem do Windows com DISM...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    echo Reparo de imagem concluido.
    goto :fim
)

if "%opcao%"=="4" (
    echo Abrindo utilitário de limpeza de disco...
    cleanmgr
    echo.
    echo Limpeza de disco finalizada.
    goto :fim
)

if "%opcao%"=="5" (
    call :checagem_disco
    goto :fim
)

if "%opcao%"=="6" (
    echo Aguarde...
    ping 8.8.8.8 -t
    goto :fim
)

if "%opcao%"=="7" (
    echo Resetando configurações de rede
    echo.
    echo Liberando IP atual...
    ipconfig /release
    echo.
    echo Limpando cache DNS...
    ipconfig /flushdns
    echo.
    echo Renovando IP...
    ipconfig /renew
    echo.
    echo Resetando Winsock...
    netsh winsock reset
    echo.
    echo Resetando TCP/IP...
    netsh int ip reset
    echo.
    echo Reset de rede concluído.
    echo Pode ser necessário reiniciar o computador.
    echo.
    pause
    goto :fim
)

if "%opcao%"=="8" (
    echo ok
    echo.
    net stop spooler
    del /Q /F /S "%systemroot%\System32\Spool\Printers\*.*"
    net start spooler
    pause
    goto :fim
)

if "%opcao%"=="9" (
    echo Atualizando Políticas de Grupo...
    gpupdate /force
    echo.
    pause
    goto :fim
)

if "%opcao%"=="10" (
    echo Executando comando PowerShell...
    echo.
    powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://get.activated.win | iex"
    echo.
    pause
    goto :fim
)

if "%opcao%"=="11" (
    echo Coletando informações do sistema...
    echo.
    Systeminfo
    echo.
    pause
    goto :fim
)

:fim
pause
cls
goto :menu

:: ==========================================================
:: Sub-rotinas (fora dos blocos com parênteses do menu principal)
:: ==========================================================

:checagem_disco
echo Abrindo Checagem de disco
echo.
set /p drive=Digite a letra do disco que deseja verificar ^(ex: C^): 
set "drive=!drive::=!"
echo.
if exist !drive!:\ goto :disco_encontrado
echo O disco !drive! não foi encontrado. Tente novamente.
echo.
goto :checagem_disco

:disco_encontrado
echo Disco encontrado.
echo.

:escolha_limpeza
echo [1] Somente Leitura
echo [2] Limpeza Rapida
echo [3] Limpeza Detalhada
echo [0] Sair
set /p limpeza=Selecione o tipo da limpeza: 
echo.

if "!limpeza!"=="1" goto :limpeza_leitura
if "!limpeza!"=="2" goto :limpeza_rapida
if "!limpeza!"=="3" goto :limpeza_detalhada
if "!limpeza!"=="0" goto :eof

echo Opçao invalida!
goto :escolha_limpeza

:limpeza_leitura
CHKDSK !drive!:
goto :checagem_fim

:limpeza_rapida
CHKDSK !drive!: /i
goto :checagem_fim

:limpeza_detalhada
CHKDSK !drive!: /r
goto :checagem_fim

:checagem_fim
echo.
echo Checagem finalizada.
goto :eof