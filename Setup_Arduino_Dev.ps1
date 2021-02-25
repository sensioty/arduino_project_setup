# Make sure the correct execution policy is set
$executionPolicy = Get-ExecutionPolicy
if($executionPolicy -eq 'Restricted') {
    Set-ExecutionPolicy AllSigned
}

$chocoVersion = powershell choco -v
if(-not($chocoVersion)) {
	# Install chocolatey
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install chocolatey packages
choco install --yes vscode
choco install --yes python
choco install --yes fritzing

# refresh environment variables so we can directly use vscode
refreshenv

# Install platformIO extension for vscode
code --install-extension platformio.platformio-ide

# Install global python packages
pip install virtualenv

# Create virtual env
python -m venv venv

# Activate the virtual env
venv/Scripts/Activate.ps1

# Install platformIO
pip install -U platformIO

# Deactivate python virtual environment
deactivate

