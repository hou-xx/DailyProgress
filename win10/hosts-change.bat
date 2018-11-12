@echo off
@chcp 65001
@echo  ++++++++++++++++++++++++++++++++
@echo  请注意你的杀毒软件提示，一定要允许
@echo  ++++++++++++++++++++++++++++++++

@echo 127.0.0.1 ad.test.com >>C:\Windows\System32\drivers\etc\hosts

@echo+
@echo   hosts文件修改完成
@echo+
@ipconfig /flushdns
@echo+
@echo   刷新DNS完成
@echo+
@echo  ++++++++++++++++++++++++++++++++
@echo  hosts文件修改成功！回车即可关闭窗口。
@echo  ++++++++++++++++++++++++++++++++
@echo+
@pause > nul
