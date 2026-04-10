@echo off
setlocal

set "URL=https://morada.ai/wp-content/uploads/2025/07/Imagem-HERO.png"

for /f "delims=" %%i in ('powershell -NoProfile -Command "[Environment]::GetFolderPath('MyPictures')"') do set "PASTA_IMAGENS=%%i"

set "ARQUIVO=%PASTA_IMAGENS%\wallpaper.png"

echo.
echo Pasta de imagens detectada:
echo %PASTA_IMAGENS%
echo.

echo Baixando imagem...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ARQUIVO%'"

if errorlevel 1 (
    echo.
    echo Erro ao baixar a imagem.
    pause
    exit /b 1
)

echo.
echo Aplicando plano de fundo...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value '%ARQUIVO%'; rundll32.exe user32.dll,UpdatePerUserSystemParameters"

if errorlevel 1 (
    echo.
    echo Erro ao aplicar o plano de fundo.
    pause
    exit /b 1
)

echo.
echo Plano de fundo alterado com sucesso.
pause