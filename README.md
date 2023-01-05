# Bobominer: A PoC Implementing T1496 with SHC

This project implements a basic downloader of a XMRig miner from Github to show a PoC example of how SHC can be used to download an external tool as explained in [this article](https://asec.ahnlab.com/en/45182/) by AhnLab.
This project SHOULD be used for educational purposes to understand how SHC can be used to compile any kind of payloads, including malicious ones. 

## Compilation Instructions

The shell script under `src` is pretty straight forward.
The attacker needs [SHC](https://github.com/neurobin/shc), Shell Script Compiler, to compile the script.
This tool can be installed easily on GNU/Linux systems.
The latest release can be downloaded directly from [Github](https://github.com/neurobin/shc/releases/tag/4.0.3).
On Ubuntu-based releases you can install it using:

```
sudo add-apt-repository ppa:neurobin/ppa
sudo apt-get update
sudo apt-get install shc
```

The basic compilation of a binary is simple:
- `-v` for activating the verbose mode.
- `-o` for the name of the compiled binary.
- `-f` for the file of the script shell to compile onto a binary.
- `-r` for activating the usage on systems different to the current one.

```
$ shc -r -v -f t1496-bobominer.sh -o bobominer
```

Alternatively, a `Makefile` is provided to compile the file under the `bin` folder.
In any case, more options to compile the binaries can be found using `shc --help` or `man shc`:

```
NAME
       shc - Generic shell script compiler

SYNOPSIS
       shc [ -e date ] [ -m addr ] [ -i iopt ] [ -x cmnd ] [ -l lopt ] [ -o outfile ] [ -ABCDhUHsvSr ] -f script
```

## Bobominer Usage

Releasing the payload is as simple as executing the executable file with the XMR Address to perform the donation.

```
$ ./bobominer <XMR_ADDRESS>
```

Note that this address will be replaced onto the default `config.json` file downloaded from Github using `sed`.

## Tools

The script is a shell script that still needs some tools to be located in the system:

- `wget` to download the compressed tar file.
- `tar` to untar the mining file.
- `sed` to replace the XMR address.

## Implemented TTPs

The MITRE Attack TTP thats are implemented in this PoC can be listed as follows.

- TA0002 Execution | [T1059.003: Command and Scripting Interpreter: Unix Shell](https://attack.mitre.org/techniques/T1059/003//) considering that SHC payloads to be run still need a shell to be identified in the system and that the code inside the payload is, in fact, a shell script.
- TA0005 Defense Evasion | [T1027.002: Obfuscated Files or Information: Software Packing](https://attack.mitre.org/techniques/T1027/002) by compiling malicious shell payload using SHC.
- TA0005 Defense Evasion | [T1622: Debugger Evasion](https://attack.mitre.org/techniques/T622/) by compiling malicious shell payload using SHC and the parameter '-r'.
- TA0011 Command & Control | [T1105: Ingress Tool Transfer](https://attack.mitre.org/techniques/T1105/) by downloading additional payloads from Github.
- TA0012 Impact | [T1496: Resource Hijacking](https://attack.mitre.org/techniques/T1496/) by means of the download of XMRig official miner from Github.

## References

[1] AhnLab (2023). "Shc Linux Malware Installing CoinMiner". Available online at: https://asec.ahnlab.com/en/45182/

