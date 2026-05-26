#!/bin/bash
# Mattermost APK 魔改构建脚本
# 用法: bash build.sh 原版.apk 输出.apk
set -e

INPUT="$1"
OUTPUT="$2"
if [ -z "$INPUT" ] || [ -z "$OUTPUT" ]; then
    echo "用法: bash build.sh <输入.apk> <输出.apk>"
    exit 1
fi

export JAVA_HOME=/vol1/jdk-17.0.2
export PATH="$JAVA_HOME/bin:/vol1/android-sdk/build-tools/35.0.0:$PATH"
APKTOOL="$HOME/opt/apktool"
SIGNER="$HOME/opt/uber-apk-signer"
TMPDIR="/tmp/mm-build-$$"

echo "▸ 反编译 $INPUT ..."
$APKTOOL d -f "$INPUT" -o "$TMPDIR"

echo "▸ 替换 network_security_config.xml ..."
cp "$(dirname "$0")/network_security_config.xml" "$TMPDIR/res/xml/"

echo "▸ 修改 AndroidManifest.xml ..."
MANIFEST="$TMPDIR/AndroidManifest.xml"
if ! grep -q 'networkSecurityConfig' "$MANIFEST"; then
    sed -i 's/<application /<application android:networkSecurityConfig="@xml\/network_security_config" /' "$MANIFEST"
fi

echo "▸ 重编译 ..."
$APKTOOL b "$TMPDIR" -o /tmp/mm-unsigned.apk

echo "▸ 签名 ..."
$SIGNER -a /tmp/mm-unsigned.apk --overwrite -o "$(dirname "$OUTPUT")"

mv "$(dirname "$OUTPUT")/mm-unsigned-aligned-debugSigned.apk" "$OUTPUT" 2>/dev/null || \
mv "$(dirname "$OUTPUT")"/*-aligned-debugSigned.apk "$OUTPUT" 2>/dev/null || echo "请手动查找签名后的 APK"

echo "▸ 完成: $OUTPUT"
rm -rf "$TMPDIR" /tmp/mm-unsigned.apk