## Simple shaper script

This script adjusts download (to wired and wireless clients) speed only.

### Prerequisites

QoS enabled firmware! You have to recompile firmware with `CONFIG_FIRMWARE_INCLUDE_QOS=y` and `CONFIG_FIRMWARE_INCLUDE_IMQ=y` first!

### Installation

* [Install Entware](https://bitbucket.org/padavan/rt-n56u/wiki/EN/HowToConfigureEntware).
* Disable hardware acceleration at `WAN` WebUI page.
* Install `tc` utility from console:
```
opkg install tc-legacy
```
* Download shaper script and make it executable:
```
wget --no-check-certificate -O /opt/etc/init.d/S10shaper https://raw.githubusercontent.com/DontBeAPadavan/simple-shaper/master/opt/etc/init.d/S10shaper
chmod +x /opt/etc/init.d/S10shaper
```
* Edit `/opt/etc/init.d/S10shaper` for your needs.
* Reboot router or (re)start shaper manually:
```
/opt/etc/init.d/S10shaper start
```
