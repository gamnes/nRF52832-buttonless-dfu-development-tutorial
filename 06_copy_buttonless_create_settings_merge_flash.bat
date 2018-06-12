

@echo off

:: # Check to make sure nrfutil and mergehex and nrfjprog are installed before moving on
WHERE >nul 2>nul nrfutil
IF %ERRORLEVEL% NEQ 0 (
ECHO "nrfutil was not found in PATH, please install using pip install"
goto :end
)
WHERE >nul 2>nul nrfjprog
IF %ERRORLEVEL% NEQ 0 (
ECHO "nrfjprog was not found in PATH, please install using windows installer from nordicsemi.com"
goto :end
)
WHERE >nul 2>nul mergehex
IF %ERRORLEVEL% NEQ 0 (
ECHO "mergehex was not found in PATH, please install using windows installer from nordicsemi.com"
goto :end
)

SET SDK_PATH=C:\nRF5_SDK_15.0.0_a53641a
SET BUTTONLESS_FW_APP_PATH_IN_SDK=examples\ble_peripheral\ble_app_buttonless_dfu\pca10040\s132\ses\Output\Release\Exe\ble_app_buttonless_dfu_pca10040_s132.hex

echo "## Looking to make sure %SDK_PATH%\%BUTTONLESS_FW_APP_PATH_IN_SDK% is present in SDK"
if not exist %SDK_PATH%\%BUTTONLESS_FW_APP_PATH_IN_SDK% (
echo "#### buttonless app FW .hex file does not exist! Please make sure you have compiled it, and check the PATHs that are used in this script!"
GOTO end
)
echo.

echo "## Copying buttonless app FW into folder and renaming it app.hex"
copy %SDK_PATH%\%BUTTONLESS_FW_APP_PATH_IN_SDK% app.hex
echo.

echo "## Running 04_bootloader_settings_merge_flash.bat in order to generate settings.hex, merge this with the app.hex, then flash it to the DK"
04_bootloader_settings_merge_flash.bat

:end
pause