yad --button gtk-apply:0 --text-info --geometry=200x200+1545+25 --class "YADWIN" --margins=10 --filename=<(pacman -Sup --print-format="%n %v" | grep -v "^::")
  if [[ $? -eq 0 ]];then
    xfce4-terminal -H --command "sudo pacmatic -Syu" -T "Menu Update"
  fi