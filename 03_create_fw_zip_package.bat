

@echo off

:: # Check to make sure nrfutil is installed before moving on
WHERE >nul 2>nul nrfutil
IF %ERRORLEVEL% NEQ 0 (
ECHO "nrfutil was not found in PATH, please install using pip install"
goto :end
)

SET S132=s132_nrf52_6.0.0_softdevice.hex
SET APPLICATION_HEX=app.hex

echo "## Looking to make sure %S132% is present in folder"
if not exist %S132% (
echo "#### s132 hex file does not exist! Please copy this file into the folder and try again!"
goto :end
)
echo.

echo "## Looking to make sure %APPLICATION_HEX% is present in folder"
if not exist %APPLICATION_HEX% (
echo "#### app.hex file does not exist! Please copy a application .hex file into the folder, rename it, and try again!"
goto :end
)
echo.

echo "## Creating a FW.zip package that can be used to update the FW on the DK"
nrfutil pkg generate --application app.hex --application-version 1 --application-version-string "1.0.0" --hw-version 52 --sd-req 0xA8 --sd-id 0xA8 --softdevice s132_nrf52_6.0.0_softdevice.hex --key-file private.pem FW.zip
echo.

:end
pause