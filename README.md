# Dell c1660w Ubuntu Configuration

It took me a little bit to work out the kinks with getting this network printer to work in a modern 64 bit Ubuntu enviornment since Dell doesn't offer linux drivers for this model.

## Driver and Dependencies

Luckily we can make use of the following driver from [Xerox](https://www.support.xerox.com/support/phaser-6000/file-download/engb.html?operatingSystem=linux&fileLanguage=en_GB&contentId=116065&from=downloads&viewArchived=false). However, this was a driver writter only for 32-bit debian systems. The dependencies I needed to run on Ubunutu 18.04 were `libcupsimage2:i386` and `libstdc++6:i386`.

## Installing the Driver

### Easy Install

Simply run the following:
```
wget -O c1660w-easy-install.sh https://raw.githubusercontent.com/joe-habel/Dell-c1660w-Ubuntu/master/install_driver.sh && sudo ./c1660w-easy-install.sh && rm c1660w-easy-install.sh
```

### Manual Install

In case you're not as comfortable with running a random script off of github. Run the following command to install the dependencies.

```
sudo apt-get install -y libcupsimage2:i386 libstdc++6:i386
```

Then agree to the EULA, download, and unzip the [.deb driver from Xerox](https://www.support.xerox.com/support/phaser-6000/file-download/engb.html?operatingSystem=linux&fileLanguage=en_GB&contentId=116065&from=downloads&viewArchived=false), and install it with

```
sudo dpkg -i xerox-phaser-6000-6010_1.0-1_i386.deb
```

## Installing the Printer

0) Make sure the Dell c1660w is setup and on the network. (You can normally check to see if it's setup by navigating to it's IP in your browser.
1) From the application menu navigate to 'Printers'
2) Select 'Add'.
3) From 'Devices', select 'Network Printer'. Wait for the 'Dell C1660w Color (XXX.XXX.XX.XX)' option to appear and select that.
4) From 'Connections', select your desired connection type. If unsure, stick with the default, and click 'Forward'.
5) From the 'Makes' list select 'Xerox' and click 'Forward'.
6) From the 'Models' list select 'Phaser 6000B' and click 'Forward'.
7) Enter in your desired name, description, and location and click 'Apply'.
8) If you reach this point and the test page does not want to print, try restarting your system.
