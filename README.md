# Mattermost 修改版 — 夏语魔改工作区

基于 `mattermost/mattermost-mobile` Android APK 的深度修改。

## NAS 环境
| 工具 | 路径 | 版本 |
|------|------|------|
| apktool | `~/opt/apktool` | 2.11.0 |
| uber-apk-signer | `~/opt/uber-apk-signer` | 1.3.0 |
| JDK | `/vol1/jdk-17.0.2` | 17.0.2 |
| apksigner | `/vol1/android-sdk/build-tools/35.0.0/` | 35.0.0 |

## 快速构建
```bash
bash build.sh <原版.apk> <输出.apk>
```

## 当前修改
- `network_security_config.xml`：信任用户证书
- `AndroidManifest.xml`：引用 networkSecurityConfig

## 魔改方向
反编译后可直接修改：
- `res/` — 图标、颜色、字符串、布局 XML
- `smali/` — Java 字节码（反编译后的 Smali 代码）
- `AndroidManifest.xml` — 权限、组件配置
- `assets/` — Web 资源、JS bundle
