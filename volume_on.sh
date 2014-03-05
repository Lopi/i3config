if [ $(amixer get Master | grep 'Mono:' | awk '{print $6}' | tr -d '[]') == "on" ]; then
  echo 1
else
  echo 0
fi