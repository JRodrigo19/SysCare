@echo off
setlocal

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

<<<<<<< Updated upstream
=======
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
    goto: fim
)

if "%opcao%"=="3" (
    echo Iniciando reparo de imagem do Windows com DISM...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    echo Reparo de imagem concluido.
)

if "%opcao%"=="4" (
    echo Abrindo utilitário de limpeza de disco...
    cleanmgr
    echo.
    echo Limpeza de disco finalizada.
)

if "%opcao%"=="5" (
    echo Abrindo Checagem de disco
    echo.
    :checagem_disco
    set /p drive=Digite a letra do disco que deseja verificar ^(ex: C^): 
    set drive=!drive::=!
    echo.
    if exist !drive!:\ (
	echo Disco encontrado.
	echo.
	:escolha_limpeza
	echo [1] Somente Leitura
	echo [2] Limpeza Rapida
        echo [3] Limpeza Detalhada
	set /p limpeza=Selecione o tipo da limpeza: 
	echo.
	if "!limpeza!"=="1" (
		CHKDSK !drive!:	
	)
	if "!limpeza!"=="2" (
		CHKDSK !drive!: /i
        )
	if "!limpeza!"=="3" (
		CHKDSK !drive!: /r
	) else (
		echo Opçao invalida!
    		goto :escolha_limpeza
	)
	echo.
	echo Checagem finalizada.
	goto :fim

    ) else (
	echo O disco !drive! não foi encontrado. Tente novamente.
	echo.
	goto :checagem_disco
    )
   
)

if "%opcao%"=="6" (
    echo Aguarde...
    ping 8.8.8.8 -t
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
)


if "%opcao%"=="8" (
    echo Abrindo Gerenciador de Dispositivos...
    start "" devmgmt.msc
    echo.
    pause
)

if "%opcao%"=="9" (
    echo Atualizando Políticas de Grupo (GPO)...
    gpupdate /force
    echo.
    pause
)


:fim
>>>>>>> Stashed changes
pause
