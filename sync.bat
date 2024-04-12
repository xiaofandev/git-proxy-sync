@echo off
:: 启动PowerShell并执行命令获取代理信息
for /f "tokens=*" %%a in ('powershell -Command "& {Get-ItemProperty -Path 'Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings' | Select-Object ProxyServer}"') do (
    set "proxy_server=%%a"
)

:: 提取代理IP和端口
for /f "tokens=1,2 delims=:" %%b in ("%proxy_server%") do (
    set "proxy_ip=%%b"
    set "proxy_port=%%c"
)

:: 输出结果
echo Proxy IP: %proxy_ip%
echo Proxy Port: %proxy_port%

:: 设置git代理
git config --global http.proxy %proxy_ip%:%proxy_port%

echo Git proxy set successfully!

pause

