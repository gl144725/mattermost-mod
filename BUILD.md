# 构建指南

## 环境

- apktool >= 2.9
- uber-apk-signer >= 1.3
- OpenJDK 17+

## 步骤

```bash
# 1. 下载官方 Unsigned APK
# https://github.com/mattermost/mattermost-mobile/releases

# 2. 反编译
apktool d -f Mattermost.apk -o mm-decomp

# 3. 替换证书配置
cp xml/network_security_config.xml mm-decomp/res/xml/

# 4. 修改 AndroidManifest.xml
# <application> 内添加：
#   android:networkSecurityConfig="@xml/network_security_config"

# 5. 重新编译
apktool b mm-decomp -o mm-unsigned.apk

# 6. 签名
uber-apk-signer -a mm-unsigned.apk --overwrite
```

## 验证

1. 安装自签证书到手机
2. 安装 APK
3. 连接自签 HTTPS → 无警告
