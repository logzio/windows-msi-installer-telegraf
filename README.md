## Telegraf Windows Packager

This project houses the windows install package for [Telegraf](https://github.com/influxdb/telegraf) version of 1.22.4, to send metrics to logz.io platform.

# Windows Package Manager

This project uses the [Wix Toolset](http://wixtoolset.org/) to generate a windows msi installer. The core of WiX is a set of build tools that build Windows Installer packages using the same build concepts as the rest of your product: source code is compiled and then linked to create executables; in this case .exe setup bundles, .msi installation packages, .msm merge modules, and .msp patches. The WiX command-line build tools work with any automated build system. Also, MSBuild is supported from the command line, Visual Studio, and Team Build.

### GUID

You need to generate some GUIDs for the installer. I used [guidgen.com](http://www.guidgen.com/)
referenced in the [generate guids guide](http://wixtoolset.org/documentation/manual/v3/howtos/general/generate_guids.html)

Inside a file `telegraf.wxs` you need to replace with unique GUID(you will see placeholder `MANDATORY-UNIQUE-GUID-HERE`)

NOTE: You have to uppercase the GUID's that this site generates to be fully compatible with the installer.

### Generating the MSI

Need to unzip `telegraf.zip` that archive contains telegraf collector.

We need to use candle to create our intermmediate object that will turn into an msi file.

```
candle.exe -nologo telegraf.wxs -out telegraf.wixobj
```

Now we can generate the msi file with this command:

```
light.exe -nologo telegraf.wixobj -out telegraf.msi
```

## To install Telegraf Collector and send metrics to Logz.io.

You need yo trigger msi installer.

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
