# Telegraf Windows Packager

This project contains a Windows Installer package to install [Telegraf](https://github.com/influxdb/telegraf) that is configured to send metrics to the Logz.io platform. This integration uses the [WiX Toolset](http://wixtoolset.org/) to generate a Windows MSI installer.

## Setup

### 1. Download and install [Wix Toolset](http://wixtoolset.org/)

1. Go to [Wix Toolset Downloads](https://wixtoolset.org/releases/)

![Wix Toolset Downloads](/img/step1.png)

2. Click `Download` to go to the github [releases page](https://github.com/wixtoolset/wix3/releases/tag/wix3112rtm) of project

![Wix Toolset Downloads](/img/step2.png)

3. Run `winx311.exe` file

![Wix Toolset Install](/img/step4.png)

4. Click `Install`

![Wix Toolset Install Complete](/img/step4finished.png)

### Clone github repository

1. Clone repository to your local folder

`git clone https://github.com/logzio/windows-msi-installer-telegraf.git .`

**NOTE:** This project uses Telegraf version 1.22.4. If you need to use a different version, run the followinf command:

```shell
> wget https://dl.influxdata.com/telegraf/releases/telegraf-<<VERSION>>_windows_amd64.zip -UseBasicParsing -OutFile telegraf-_windows_amd64.zip
> Expand-Archive .\telegraf-<<VERSION>>_windows_amd64.zip -DestinationPath 'C:\Program Files\InfluxData\telegraf\'
```

Replace `<<VERSION>>` with the required version number.

![Clone Repo](/img/step5clone.png)

2. Unzip `telegraf.zip`

![Unzip](/img/step6unzip.png)

### Use WiX toolset

1. Go to `Program Files` and open the WiX folder `Wix Toolset v3.11`, then open `bin` folder

![WiX folder](/img/7listof.png)

We need 2 files: `candle.exe` and `light.exe`

2. Open command line and go to your project folder

![Commandline](/img/7goto.png)

3. Drag `candle.exe` into the command line to generate the path to the `candle.exe`

At the end of the generated path, add:

`-nologo telegraf.wxs -out telegraf.wixobj` and press `Enter`

![Clone Repo](/img/9drag-candle.png)

5. A new file `telegraf.wixobj` will appear in your project folder

![Run candle.exe](/img/9finish.png)

6. Drag `light.exe` into command line to generate the path to the `light.exe`

At the end of the generated path, add:

`-nologo telegraf.wixobj -out telegraf.msi` and press `Enter`

![Run light.exe](/img/10start.png)

7. A new file `telegraf.msi` will appear in your project folder

![Run light.exe](/img/10finish.png)

MSI installer is now ready.

## Install Telegraf Collector and send metrics to Logz.io.

That msi installer only runs in **_silent mode_**.

Run the following command:

```
msiexec /i telegraf.msi LOGZIOLISTENER="<<LOGZIO_LISTENER>>" LOGZIOTOKEN="<<LOGZIO_TOKEN>>" INSTALLDIR="<<INSTALL_DIRECTION>>"
```

Replace the variables indicated between `<<>>` as per the table below:

##### Parameters

| Parameter         | Description                                                                                                                               |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| LOGZIO_TOKEN      | Your Logz.io account [token](<(https://app.logz.io/#/dashboard/settings/general)>).                                                       |
| LOGZIO_LISTENER   | Logz.io [listener URL](https://docs.logz.io/user-guide/accounts/account-region.html) to ship the logs to (for example, listener.logz.io). |
| INSTALL_DIRECTION | The folder alias of the predefined product installation folder.                                                                           |

### Check Logz.io for your metrics

Give your logs some time to get from your system to ours, and then open [Metrics](https://app.logz.io/#/dashboard/metrics).

## Versions

-   1.0.0:
    -   Initial Release

## License

Licensed under the [Apache 2.0](http://apache.org/licenses/LICENSE-2.0.txt) License.
