VOL=`/home/lopi/.scripts/pacvol.sh display | sed "s/[^1-9]//" | sed "s/%//"`
OUT=`yad --text="Volume" --scale --value $VOL --button gtk-ok:0 --geometry=125x200+1615+25 --class "YADWIN" --vertical --text-align center`
  if [[ $? -eq 0 ]];then
    amixer set Master $OUT%
  fi