## Simple shaper script

This script adjusts download (to wired and wireless clients) speed only.

### Prerequisites

QoS enabled firmware! You have to recompile firmware with `CONFIG_FIRMWARE_INCLUDE_QOS=y` and `CONFIG_FIRMWARE_INCLUDE_IMQ=y` first!

### Installation

1. [Install Entware](https://bitbucket.org/padavan/rt-n56u/wiki/EN/HowToConfigureEntware).
2. Disable hardware acceleration at `WAN` WebUI page.
3. Install `tc` utility from console:
```
opkg install tc-legacy
```
4. Download shaper script and make it executable:
```
wget --no-check-certificate -O /opt/etc/init.d/S10shaper https://raw.githubusercontent.com/DontBeAPadavan/simple-shaper/master/opt/etc/init.d/S10shaper
chmod +x /opt/etc/init.d/S10shaper
```
5. Edit `/opt/etc/init.d/S10shaper` for your needs.
6. Reboot router or (re)start shaper manually:
```
/opt/etc/init.d/S10shaper start
```
