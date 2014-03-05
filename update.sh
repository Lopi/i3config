yad --button gtk-apply:0 --text-info --geometry=350x300+1565+25 --class "YADWIN" --margins=10 --filename=<(pacman -Sup --print-format="%n %v" | grep -v "^::";cower -bu | tr -d ':: ') 
  if [[ $? -eq 0 ]];then
    urxvt -geometry 100x30+1210+25 -title "Menu Update" -e pacmatic -Syu
  fi