# RouterOS-Aliyun-DDNS

# 实现效果
在RouterOS上通过脚本自动获取动态公网IP（跟运营商申请），并更新阿里云域名DNS。实现外网访问家庭NAS的需求。

# 使用方法
- 在阿里云函数FC上部署服务端程序，用于更新DNS。创建FC实例，请求处理程序类型：HTTP请求，然后选择hello world作为模版，并把aliyun-ddns.js代码粘贴进去，部署好。
先通过mock数据调试好接口。
地址：https://fcnext.console.aliyun.com/overview

- 在RouterOS上添加脚本，脚本内容复制aliyun-ddns-ros-script.sh，并替换相关参数，设置在PPPoE拨号成功后延迟几秒钟执行。
