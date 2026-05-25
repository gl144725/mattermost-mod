# Mattermost 自定义修改版

基于 Mattermost 官方 APK 修改，适配自签 SSL 证书环境。

## 修改内容

- **network_security_config.xml**: 信任系统 + 用户证书，支持自签证书
- 不动源码，仅改 XML 配置

## 安装前提

1. 手机上安装自签证书（设置 → 安全 → 加密与凭据 → 从存储设备安装）
2. 安装本修改版 APK

## 构建方式

详见 BUILD.md

## 当前版本

- Mattermost v2.26.0
- 修改日期：2026-05-25
