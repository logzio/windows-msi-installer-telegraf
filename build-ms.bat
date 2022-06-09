@echo off

@echo [[outputs.http]]  > telegraf.conf
@echo  url="%2" >> telegraf.conf
@echo   data_format="prometheusremotewrite"  >> telegraf.conf
@echo   [outputs.http.headers] >> telegraf.conf
@echo      Content-Type="application/x-protobuf"  >> telegraf.conf
@echo      Content-Encoding="snappy"  >> telegraf.conf
@echo      X-Prometheus-Remote-Write-Version="0.1.0"  >> telegraf.conf
@echo     Authorization="Bearer %1"  >> telegraf.conf
@echo [[inputs.cpu]]  >> telegraf.conf
@echo   percpu=false  >> telegraf.conf
@echo   totalcpu=true  >> telegraf.conf
@echo   collect_cpu_time=true  >> telegraf.conf
@echo   report_active=true >> telegraf.conf
@echo [[inputs.mem]] >> telegraf.conf
@echo [[inputs.system]] >> telegraf.conf
@echo    namepass=["system"] >> telegraf.conf
@echo [[inputs.disk]] >> telegraf.conf
@echo  ignore_fs=["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"] >> telegraf.conf
@echo [[inputs.diskio]]  >> telegraf.conf
@echo [[inputs.net]] >> telegraf.conf
@echo [[inputs.processes]] >> telegraf.conf
@echo [[inputs.procstat]] >> telegraf.conf
@echo pattern=".*" >> telegraf.conf
@echo   fieldpass=["cpu_usage", "memory_rss"] >> telegraf.conf


