# DisabledSecurityGoogle
杀掉浏览器进程，并以禁用同源策略的方式打开新的浏览器页面，利于开发人员本地调试。

## 问题描述
mind-ui项目因为跨域问题，每次联调都需要以下几个步骤才能开始联调：

关闭所有Google Chrome进程
1.执行命令行 open -a Google\ Chrome --args --disable-web-security --user-data-dir --disable
2.features=CrossSiteDocumentBlockingIfIsolating 

## 脚本工作流程
1.使用 pgrep 命令查询Google Chrome进程最小的进程编号，并使用变量 ppid 保存。ppid=$(pgrep -o "Google Chrome")
2.判断ppid是否为空。
3.ppid为空表示当前无浏览器进程，直接打开新的浏览器。
4.ppid不为空表示当前已有浏览器进程，等待用户输入确认是否关闭浏览器进程并继续。
5.用户输入yes后，使用 kill 关闭已打开的浏览器进程。kill $ppid
6.等待1s，确定kill进程执行完毕。sleep 1
7.使用 open 命令打开新的浏览器。open -a Google\ Chrome --args --disable-web-security --user-data-dir --disable-features=CrossSiteDocumentBlockingIfIsolating
8.等待用户确认后 exit 退出终端。

## 使用方式
下载脚本后，右键选择 "终端" 运行，并勾选 "始终以此方式打开"。下次运行直接双击。

脚本执行完毕后，回车退出脚本。

## 注意事项
此脚本暂时只在本机 Mac 系统上测试过，不保证Windows\Linux运行正常。
可以在 终端→偏好设置→描述文件→Shell 中设置 "当shell退出时" 为 "当shell完全退出后关闭" 。
  
