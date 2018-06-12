

@echo off

:: # Check to make sure nrfjprog is installed before moving on
WHERE >nul 2>nul nrfjprog
IF %ERRORLEVEL% NEQ 0 (
ECHO "nrfjprog was not found in PATH, please install using windows installed as found on nordicsemi.com"
goto :end
)
WHERE >nul 2>nul mergehex
IF %ERRORLEVEL% NEQ 0 (
ECHO "mergehex was not found in PATH, please install using windows installed as found on nordicsemi.com"
goto :end
)

SET S132=s132_nrf52_6.0.0_softdevice.hex
SET BOOTLOADER=bootloader.hex

echo "## Looking to make sure %S132% exists"
if not exist %S132% (
echo "#### s132 hex file does not exist! Make sure the softdevice is in the same folder as this script!"
goto :end
)
echo.

echo "## Looking to make sure %BOOTLOADER% exists"
if not exist %BOOTLOADER% (
echo "#### Bootloader hex file does not exist! Please make sure its compiled, copied, and renamed into this folder!"
goto :end
)
echo.

echo "## Merging S132 and bootloader, then flashing it to nRF52-DK; make sure the DK is powered on and connected to the PC"
mergehex -m %S132% %BOOTLOADER% -o merged_SD_bootloader.hex
nrfjprog --program merged_SD_bootloader.hex --chiperase
echo.

echo "## Please power cycle the DK and then with nRF Connect, make sure the board is in bootloader mode and ADV as DfuTarg"
echo.

:end
pause