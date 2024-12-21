
@set /p ip="请输入路由器ip: "
@set /p stok="请输入stok: "

@echo 启用SSH...
@curl -X GET "http://%ip%/cgi-bin/luci/;stok=%stok%/api/misystem/set_sys_time?time=2023-2-19%%2023:4:47&timezone=CST-8"
@echo.
@curl -X POST "http://%ip%/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_setting%%22%%2C%%22name%%22%%3A%%22'%%24(sed%%20-i%%20s%%2Frelease%%2FXXXXXX%%2Fg%%20%%2Fetc%%2Finit.d%%2Fdropbear)'%%22%%2C%%22action_list%%22%%3A%%5B%%7B%%22thirdParty%%22%%3A%%22xmrouter%%22%%2C%%22delay%%22%%3A17%%2C%%22type%%22%%3A%%22wan_block%%22%%2C%%22payload%%22%%3A%%7B%%22command%%22%%3A%%22wan_block%%22%%2C%%22mac%%22%%3A%%2200%%3A00%%3A00%%3A00%%3A00%%3A00%%22%%7D%%7D%%5D%%2C%%22launch%%22%%3A%%7B%%22timer%%22%%3A%%7B%%22time%%22%%3A%%223%%3A1%%22%%2C%%22repeat%%22%%3A%%220%%22%%2C%%22enabled%%22%%3Atrue%%7D%%7D%%7D"
@echo.
@curl -X POST "http://%ip%/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_start_by_crontab%%22%%2C%%22time%%22%%3A%%223%%3A1%%22%%2C%%22week%%22%%3A0%%7D"
@echo.
@curl -X POST "http://%ip%/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_setting%%22%%2C%%22name%%22%%3A%%22'%%24(nvram%%20set%%20ssh_en%%3D1)'%%22%%2C%%22action_list%%22%%3A%%5B%%7B%%22thirdParty%%22%%3A%%22xmrouter%%22%%2C%%22delay%%22%%3A17%%2C%%22type%%22%%3A%%22wan_block%%22%%2C%%22payload%%22%%3A%%7B%%22command%%22%%3A%%22wan_block%%22%%2C%%22mac%%22%%3A%%2200%%3A00%%3A00%%3A00%%3A00%%3A00%%22%%7D%%7D%%5D%%2C%%22launch%%22%%3A%%7B%%22timer%%22%%3A%%7B%%22time%%22%%3A%%223%%3A2%%22%%2C%%22repeat%%22%%3A%%220%%22%%2C%%22enabled%%22%%3Atrue%%7D%%7D%%7D"
@echo.
@curl -X POST "http://%ip%/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_start_by_crontab%%22%%2C%%22time%%22%%3A%%223%%3A2%%22%%2C%%22week%%22%%3A0%%7D"
@echo.
@curl -X POST "http://"%ip%"/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_setting%%22%%2C%%22name%%22%%3A%%22'%%24(nvram%%20commit)'%%22%%2C%%22action_list%%22%%3A%%5B%%7B%%22thirdParty%%22%%3A%%22xmrouter%%22%%2C%%22delay%%22%%3A17%%2C%%22type%%22%%3A%%22wan_block%%22%%2C%%22payload%%22%%3A%%7B%%22command%%22%%3A%%22wan_block%%22%%2C%%22mac%%22%%3A%%2200%%3A00%%3A00%%3A00%%3A00%%3A00%%22%%7D%%7D%%5D%%2C%%22launch%%22%%3A%%7B%%22timer%%22%%3A%%7B%%22time%%22%%3A%%223%%3A3%%22%%2C%%22repeat%%22%%3A%%220%%22%%2C%%22enabled%%22%%3Atrue%%7D%%7D%%7D"
@echo.
@curl -X POST "http://%ip%/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_start_by_crontab%%22%%2C%%22time%%22%%3A%%223%%3A3%%22%%2C%%22week%%22%%3A0%%7D"
@echo.
@curl -X POST "http://%ip%/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_setting%%22%%2C%%22name%%22%%3A%%22'%%24(%%2Fetc%%2Finit.d%%2Fdropbear%%20enable)'%%22%%2C%%22action_list%%22%%3A%%5B%%7B%%22thirdParty%%22%%3A%%22xmrouter%%22%%2C%%22delay%%22%%3A17%%2C%%22type%%22%%3A%%22wan_block%%22%%2C%%22payload%%22%%3A%%7B%%22command%%22%%3A%%22wan_block%%22%%2C%%22mac%%22%%3A%%2200%%3A00%%3A00%%3A00%%3A00%%3A00%%22%%7D%%7D%%5D%%2C%%22launch%%22%%3A%%7B%%22timer%%22%%3A%%7B%%22time%%22%%3A%%223%%3A4%%22%%2C%%22repeat%%22%%3A%%220%%22%%2C%%22enabled%%22%%3Atrue%%7D%%7D%%7D"
@echo.
@curl -X POST "http://"%ip%"/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_start_by_crontab%%22%%2C%%22time%%22%%3A%%223%%3A4%%22%%2C%%22week%%22%%3A0%%7D"
@echo.
@curl -X POST "http://"%ip%"/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_setting%%22%%2C%%22name%%22%%3A%%22'%%24(%%2Fetc%%2Finit.d%%2Fdropbear%%20restart)'%%22%%2C%%22action_list%%22%%3A%%5B%%7B%%22thirdParty%%22%%3A%%22xmrouter%%22%%2C%%22delay%%22%%3A17%%2C%%22type%%22%%3A%%22wan_block%%22%%2C%%22payload%%22%%3A%%7B%%22command%%22%%3A%%22wan_block%%22%%2C%%22mac%%22%%3A%%2200%%3A00%%3A00%%3A00%%3A00%%3A00%%22%%7D%%7D%%5D%%2C%%22launch%%22%%3A%%7B%%22timer%%22%%3A%%7B%%22time%%22%%3A%%223%%3A5%%22%%2C%%22repeat%%22%%3A%%220%%22%%2C%%22enabled%%22%%3Atrue%%7D%%7D%%7D"
@echo.
@curl -X POST "http://%ip%/cgi-bin/luci/;stok=%stok%/api/xqsmarthome/request_smartcontroller" -d "payload=%%7B%%22command%%22%%3A%%22scene_start_by_crontab%%22%%2C%%22time%%22%%3A%%223%%3A5%%22%%2C%%22week%%22%%3A0%%7D"
@echo.
@echo 启用 SSH 完成(临时),可使用https://miwifi.dev/ssh查询密码。
@echo 连接 SSH 后, 执行 date -s "2024-03-11 21:54:30" 以校准时间。(更改为实际时间)
@endlocal
@pause