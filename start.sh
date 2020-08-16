#!/bin/bash

function telegram_notify()
{
  curl -d parse_mode="Markdown" -d text="${1}" https://api.telegram.org/bot"${BOT_TOKEN}"/sendMessage?chat_id="${CHAT_ID}"
}

telegram_notify "开始新的构建，Spigot 版本为 ${VERSION}。"
START=$(date +"%s")
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev ${VERSION}
curl -F document=@spigot-"${VERSION}".jar https://api.telegram.org/bot"${BOT_TOKEN}"/sendDocument?chat_id="${CHAT_ID}"
END=$(date +"%s")
DURTION=$((END - START))
telegram_notify "构建完毕，此次构建耗时 $((DURTION / 60)) 分 $((DURTION % 60)) 秒。"
