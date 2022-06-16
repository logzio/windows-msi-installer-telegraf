# Telegraf Windows Packager

This project houses the windows install package for [Telegraf](https://github.com/influxdb/telegraf) version of 1.22.4, to send metrics to logz.io platform.

## Windows Package Manager

This project uses the [Wix Toolset](http://wixtoolset.org/) to generate a windows msi installer. The core of WiX is a set of build tools that build Windows Installer packages using the same build concepts as the rest of your product: source code is compiled and then linked to create executables; in this case .exe setup bundles, .msi installation packages, .msm merge modules, and .msp patches. The WiX command-line build tools work with any automated build system. Also, MSBuild is supported from the command line, Visual Studio, and Team Build.

## How to

-   1. Download and install [Wix Toolset](http://wixtoolset.org/)

Go to [Wix Toolset Downloads](https://wixtoolset.org/releases/)
![Wix Toolset Downloads](/img/step1.png)

Click on a button `Download` it will forward you to the github [releases page](https://github.com/wixtoolset/wix3/releases/tag/wix3112rtm) of project
![Wix Toolset Downloads](/img/step2.png)

Run `winx311.exe` file
![Wix Toolset Install](/img/step4.png)

Click on Install button and on the end of the proccess
![Wix Toolset Install Complete](/img/step4finished.png)

-   2.  Clone github repository

Clone repository to your local folder
`git clone https://github.com/logzio/windows-msi-installer-telegraf.git .`

![Clone Repo](/img/step5clone.png)

Need to unzip `telegraf.zip` that archive contains telegraf collector.
![Unzip](/img/step6unzip.png)

-   3. Use WiX toolset

Go to your `Program Files` open WiX folder `Wix Toolset v3.11` open `bin` folder you will see list of files
![WiX folder](/img/7listof.png)

From that folder we need 2 files `candle.exe` and `light.exe`

Open command line, go to project folder
![Commandline](/img/7goto.png)

Drag `candle.exe` to command line it will auto complete routing to the `candle.exe` and add command
`-nologo telegraf.wxs -out telegraf.wixobj` and click `Enter`
![Clone Repo](/img/9drag-candle.png)

In your project folder appear new file `telegraf.wixobj`
![Run candle.exe](/img/9finish.png)

Drag `light.exe` to command line it will auto complete routing to the `light.exe` and add command
`-nologo telegraf.wixobj -out telegraf.msi` and click `Enter`
![Run light.exe](/img/10start.png)

In your project folder appear new file `telegraf.msi`
![Run light.exe](/img/10finish.png)

MSI installer is ready.

## To install Telegraf Collector and send metrics to Logz.io.

You need to trigger msi installer.

```
msiexec /i telegraf.msi LOGZIOLISTENER="<<LOGZIO_LISTENER>>" LOGZIOTOKEN="<<LOGZIO_TOKEN>>" INSTALLDIR="<<INSTALL_DIRECTION>>"
```

##### Parameters

| Parameter                                              | Description                                                                                                                               |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| LOGZIO_TOKEN <span class="required-param"></span>      | Your Logz.io account [token](<(https://app.logz.io/#/dashboard/settings/general)>).                                                       |
| LOGZIO_LISTENER <span class="required-param"></span>   | Logz.io [listener URL](https://docs.logz.io/user-guide/accounts/account-region.html) to ship the logs to (for example, listener.logz.io). |
| INSTALL_DIRECTION <span class="required-param"></span> | The folder alias of the predefined product installation folder.                                                                           |

### Check Logz.io for your metrics

Give your logs some time to get from your system to ours,
and then open [Metrics](https://app.logz.io/#/dashboard/metrics).

## Versions

-   1.0.0:
    -   Initial Release

## License

Licensed under the [Apache 2.0](http://apache.org/licenses/LICENSE-2.0.txt) License.
