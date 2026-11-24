@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo === Publicar o DATA CENTER no GitHub (script nao testado: se falhar, use o PUBLICAR.md) ===
where git >nul 2>&1 || (echo Instale o Git: https://git-scm.com/download/win & pause & exit /b)
where gh >nul 2>&1 || (echo Instale o GitHub CLI: https://cli.github.com & pause & exit /b)
gh auth status >nul 2>&1 || gh auth login
for /f "delims=" %%u in ('gh api user --jq .login') do set USR=%%u
set /p NOME=Nome do repositorio (Enter = datacenter): 
if "%NOME%"=="" set NOME=datacenter
git config user.email >nul 2>&1 || git config user.email "%USR%@users.noreply.github.com"
git config user.name >nul 2>&1 || git config user.name "%USR%"
if not exist .git git init -b main
git add -A
git commit -m "DATA CENTER" >nul 2>&1
gh repo create %NOME% --public --source=. --remote=origin --push
gh api -X POST repos/%USR%/%NOME%/pages -f "source[branch]=main" -f "source[path]=/" >nul 2>&1
echo.
echo Repositorio: https://github.com/%USR%/%NOME%
echo Site (aparece em 1 a 2 minutos): https://%USR%.github.io/%NOME%/
echo Falta: preencher o config.js com os dados do Firebase (PUBLICAR.md, passo B) e autorizar o dominio no Firebase.
pause
