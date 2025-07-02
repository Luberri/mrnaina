@echo off
setlocal enabledelayedexpansion

:: Source and destination directories
set "SOURCE_DIR=D:\S4\optim-Aina\ireto"
set "DEST_DIR=D:\S4\optim-Aina\naina\src\main\webapp\WEB-INF\views"

:: Check if source directory exists
if not exist "%SOURCE_DIR%\" (
    echo Source directory "%SOURCE_DIR%" does not exist.
    pause
    exit /b
)

:: Check if destination directory exists
if not exist "%DEST_DIR%\" (
    echo Destination directory "%DEST_DIR%" does not exist. Creating it...
    mkdir "%DEST_DIR%"
)

:: Create subdirectories for JSP files
echo Creating JSP directory structure...
mkdir "%DEST_DIR%\adherent" 2>nul
mkdir "%DEST_DIR%\livre" 2>nul
mkdir "%DEST_DIR%\pret" 2>nul
mkdir "%DEST_DIR%\reservation" 2>nul

:: Copy JSP files to their respective destinations
echo Copying index.jsp...
if exist "%SOURCE_DIR%\index.jsp" (
    copy "%SOURCE_DIR%\index.jsp" "%DEST_DIR%\index.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied index.jsp
    ) else (
        echo Failed to copy index.jsp
    )
) else (
    echo File index.jsp not found in source directory
)

echo Copying adherent_list.jsp...
if exist "%SOURCE_DIR%\adherent_list.jsp" (
    copy "%SOURCE_DIR%\adherent_list.jsp" "%DEST_DIR%\adherent\adherent_list.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied adherent_list.jsp
    ) else (
        echo Failed to copy adherent_list.jsp
    )
) else (
    echo File adherent_list.jsp not found in source directory
)

echo Copying adherent_form.jsp...
if exist "%SOURCE_DIR%\adherent_form.jsp" (
    copy "%SOURCE_DIR%\adherent_form.jsp" "%DEST_DIR%\adherent\adherent_form.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied adherent_form.jsp
    ) else (
        echo Failed to copy adherent_form.jsp
    )
) else (
    echo File adherent_form.jsp not found in source directory
)

echo Copying livre_list.jsp...
if exist "%SOURCE_DIR%\livre_list.jsp" (
    copy "%SOURCE_DIR%\livre_list.jsp" "%DEST_DIR%\livre\livre_list.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied livre_list.jsp
    ) else (
        echo Failed to copy livre_list.jsp
    )
) else (
    echo File livre_list.jsp not found in source directory
)

echo Copying livre_form.jsp...
if exist "%SOURCE_DIR%\livre_form.jsp" (
    copy "%SOURCE_DIR%\livre_form.jsp" "%DEST_DIR%\livre\livre_form.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied livre_form.jsp
    ) else (
        echo Failed to copy livre_form.jsp
    )
) else (
    echo File livre_form.jsp not found in source directory
)

echo Copying pret_list.jsp...
if exist "%SOURCE_DIR%\pret_list.jsp" (
    copy "%SOURCE_DIR%\pret_list.jsp" "%DEST_DIR%\pret\pret_list.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied pret_list.jsp
    ) else (
        echo Failed to copy pret_list.jsp
    )
) else (
    echo File pret_list.jsp not found in source directory
)

echo Copying pret_form.jsp...
if exist "%SOURCE_DIR%\pret_form.jsp" (
    copy "%SOURCE_DIR%\pret_form.jsp" "%DEST_DIR%\pret\pret_form.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied pret_form.jsp
    ) else (
        echo Failed to copy pret_form.jsp
    )
) else (
    echo File pret_form.jsp not found in source directory
)

echo Copying reservation_list.jsp...
if exist "%SOURCE_DIR%\reservation_list.jsp" (
    copy "%SOURCE_DIR%\reservation_list.jsp" "%DEST_DIR%\reservation\reservation_list.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied reservation_list.jsp
    ) else (
        echo Failed to copy reservation_list.jsp
    )
) else (
    echo File reservation_list.jsp not found in source directory
)

echo Copying reservation_form.jsp...
if exist "%SOURCE_DIR%\reservation_form.jsp" (
    copy "%SOURCE_DIR%\reservation_form.jsp" "%DEST_DIR%\reservation\reservation_form.jsp" >nul
    if !errorlevel! equ 0 (
        echo Successfully copied reservation_form.jsp
    ) else (
        echo Failed to copy reservation_form.jsp
    )
) else (
    echo File reservation_form.jsp not found in source directory
)

echo.
echo JSP file copying completed.
pause