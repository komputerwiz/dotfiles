#!/bin/bash

# Copyright (C) 2014 Pablo Zubieta. <http://pabloferz.deviantart.com/>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

while getopts :bBc:C:ef:i:ln:p:rs:S:tuwx:X:y:Y: OPT; do
case $OPT in
   b) B=1;;                     # Bold city name
   B) BB=1;;                    # Bold conditions
   c) COLOR=$OPTARG;;           # icon color spec
   C) HEX=$OPTARG;;             # hex icon color (without leading '#")
   e) E=1;;                     # Fahrenheit instead of celcius
   f) FONT=$OPTARG;;
   i) LOCID=$OPTARG;;           # Location ID
   l) CONKYLANG=$OPTARG;;       # 2-digit language code
   m) SUMMARY=1;;               # show city and temperature summary
   n) SHOWCOND=1;;              # Conditions
   p) CITY=$OPTARG;;            # City Name
   r) RIGHT=1;;                 # Align right
   s) SIZE=$OPTARG;;            # Font size
   S) ISIZE=$OPTARG;;           # Icon size (square)
   t) TS=1;;                    # Feels like
   u) U=1;;                     # UV index
   w) W=1;;                     # Wind
   x) X=$OPTARG;;               # X offset
   X) IX=$OPTARG;;              # Icon X offset
   y) Y=$OPTARG;;               # Y offset
   Y) IY=$OPTARG;;              # Icon Y offset
esac
done

download () {

   wget -O $FILE --load-cookies=$CONKYPATH/cookies/$TU.txt "http://m.$CONKYLANG.weather.com/${LDATA[0]}/$LOCID"
   sed -i 's/^[ \t\r]*//;s/\r$//;/^$/d' $FILE

   DF=$(cat $FILE | grep 'The Weather Channel' | wc -l)
   TEMP=$(cat $FILE | grep 'temp">' | sed 's/&.*//;s/.*>//')
   if [ "$DF" = "0" -o -z "$TEMP" ]; then
      NETSTAT=0
   else
      NETSTAT=1
      FLTEMP=$(cat $FILE | grep 'els"' | sed 's/&.*//;s/.* //')
      WIND=$(cat $FILE | grep -m1 -A2 'w-type"' | tail -1 | sed 's/[^0-9]//g')
      UV=$(cat $FILE | grep -m3 -A2 'w-type"' | tail -2 | head -1 | sed 's/<\/.*//;s/.*>//')
      COND=$(cat $FILE | grep 'ase">' | sed 's/<\/.*//;s/.*>//')
      ICON=$(cat $FILE | grep '/256' | sed 's/\.p.*//;s/.*\///')
   fi

}

download_it () {

   wget -O $FILE-it "http://www.classmeteo.it/meteo/cm/mobile-previsioni.xhtml?idCity=$LOCID"
   sed -i 's/^[ \t\r]*//;s/\r$//;/^$/d' $FILE-it

   UV=$(cat $FILE-it | grep 'V:' | sed 's/^[^0-9]*//;s/[^)]*$//')
   COND=$(cat $FILE-it | grep -A3 'lib' | tail -1)

}

if [ -z "$CITY" ]; then
   echo 'A city name must be supplied (weather.sh -p "City Name").'
elif [ -z "$LOCID" ]; then
   echo 'A location ID must be supplied (weather.sh -i "LocID"). Find yours at http://aspnetresources.com/tools/weatherIdResolver'
else

   case $CONKYLANG in
      br) LDATA=("agora" "Sensação: " "Vento: " "Índice UV: " "Tranquilo");;
      ca) LDATA=("ara_mateix" "Sensació tèrmica: " "Vent: " "Índex UV: " "Calmat");;
      cs) LDATA=("pr%C3%A1v%C4%9B_te%C4%8F" "Pocitová teplota: " "Vítr: " "UV-Index: " "Bezvětří");;
      da) LDATA=("lige_nu" "Føles som: " "Vind: " "UV-Indeks: " "Rolig");;
      de) LDATA=("aktuelle_Lage" "Gefühlte Temperatur: " "Wind: " "UV-Index: " "Ruhig");;
      el) LDATA=("%CF%84%CF%8E%CF%81%CE%B1" "Αίσθηση: " "Άνεμος: " "Δείκτης UV: " "Άπνοια");;
      es) LDATA=("condiciones_actuales" "Sensación térmica: " "Viento: " "Índice UV: " "En calma");;
      fi) LDATA=("juuri_nyt" "Tuntuu kuin: " "Tuuli: " "UV-Indeksi: " "Viileää");;
      fr) LDATA=("conditions_actuelles" "Température ressentie : " "Vent : " "Indice UV : " "Calme");;
      hi) LDATA=("%E0%A4%85%E0%A4%AD%E0%A5%80" "जैसा महसूस करते हैं: " "हवा: " "यूवी घाताँक: " "शांत");;
      hk) LDATA=("%E7%8F%BE%E5%9C%A8" "感覺像: " "風: " "紫外線指數: " "無風"); CONKYLANG="zhhk";;
      hr) LDATA=("trenuta%C4%8Dno" "Osjećaj kao: " "Vjetar: " "UV Indeks: " "Mirno");;
      hu) LDATA=("%C3%A9ppen_most" "Olyan, mint: " "Szél: " "UV Index: " "Nyugodt");;
      id) LDATA=("saat_ini" "Terasa Seperti: " "Angin: " "Indeks UV: " "Tenang");;
      it) LDATA=("right_now" "Percepita: " "Vento: " "Indice UV: " "Assente");;
      ja) LDATA=("%E7%8F%BE_%E5%9C%A8" "体感温度: " "風: " "紫外線指数: " "無風");;
      ko) LDATA=("%EC%A7%80%EA%B8%88_%ED%98%84%EC%9E%AC" "체감 온도: " "바람: " "자외선(UV) 지수: " "고요");;
      ms) LDATA=("sekarang" "Berasa Seperti: " "Angin: " "Indeks UV: " "Tenang");;
      nl) LDATA=("op_dit_moment" "Voelt als: " "Wind: " "UV-Index: " "Kalm");;
      no) LDATA=("akkurat_n%C3%A5" "Føles som: " "Vind: " "UV-Indeks: " "Vindstille");;
      pl) LDATA=("w_tej_chwili" "Odczuwane jako: " "Wiatr: " "Wskaźnik UV: " "Spokojnie");;
      pt) LDATA=("agora" "Parece: " "Vento: " "Índice UV: " "Calmo");;
      ro) LDATA=("chiar_acum" "Resimţit: " "Vânt: " "Indice UV: " "Acalmie");;
      ru) LDATA=("%D0%BF%D1%80%D1%8F%D0%BC%D0%BE_%D1%81%D0%B5%D0%B9%D1%87%D0%B0%D1%81" "По ощущениям: " "Ветер: " "УФ-индекс: " "Безветренная");;
      sk) LDATA=("pr%C3%A1ve_teraz" "Pocitová teplota: " "Vietor: " "UV Index: " "Bezvetrie");;
      sv) LDATA=("just_nu" "Känns som: " "Vind: " "UV-Index: " "Stiltje");;
      th) LDATA=("%E0%B8%82%E0%B8%93%E0%B8%B0%E0%B8%99%E0%B8%B5%E0%B9%89" "รู้สึกเหมือนว่า: " "ลม: " "ดัชนี UV: " "เงียบสงบ");;
      tr) LDATA=("%C5%9Fimdi" "Hissedilen: " "Rüzgar: " "UV Endeksi: " "Sakin");;
      tw) LDATA=("%E7%AB%8B%E5%8D%B3" "感覺溫度: " "風: " "紫外線指數: " "無風"); CONKYLANG="zhtw";;
      ua) LDATA=("%D0%BF%D1%80%D0%BE%D1%81%D1%82%D0%BE_%D0%B7%D0%B0%D1%80%D0%B0%D0%B7" "За відчуттями: " "Вітер: " "УФ-індекс: " "Без вітру"); CONKYLANG="ukr";;
      vi) LDATA=("ngay_l%C3%BAcn%C3%A0y" "Cảm Thấy Như: " "Gió: " "Chỉ số UV: " "Lặng gió");;
      zh) LDATA=("%E5%8D%B3_%E6%97%B6" "感觉温度: " "风: " "紫外线指数: " "无风");;
      * ) LDATA=("right_now" "Feels like: " "Wind: " "UV Index: " "Calm"); CONKYLANG="in";;
   esac

   declare -A UA=([zh]=1 [hk]=1 [tw]=1)

   CONKYPATH=$(echo $0 | sed 's/\/weather.sh//')
   FILE="/tmp/weather-$LOCID-$CONKYLANG"
   rm -f $FILE*

   if [ "$E" = "1" ]; then
      TU="e"
      UNIT=" °F"
      if [ "${UA[$CONKYLANG]}" ]; then WUNIT=" 英里/小时"; else WUNIT=" mph"; fi
   else
      TU="m"
      UNIT=" °C"
      if [ "${UA[$CONKYLANG]}" ]; then WUNIT=" 公里/小时"; else WUNIT=" km/h"; fi
   fi

   if [[ ! "$SIZE" =~ ^[0-9]+$ ]]; then SIZE=12; fi
   BFSIZE=":size=$SIZE"
   if [ "$B" = "1" ]; then BBOLD=":Bold"; fi
   if [ "$BB" = "1" ]; then BBOLD=":Bold"; BOLD=":Bold"; fi

   if [ "$CONKYLANG" = "it" ]; then 
      CONKYLANG="in"; download
      if [ "$NETSTAT" = "1" ]; then download_it; fi
   else
      download
   fi

   if [ "$NETSTAT" = "0" ]; then
      echo "\${font $FONT$BBOLD$BFSIZE}$CITY"
   else

      if [[ "$Y" =~ ^-?[0-9]+$ ]]; then YSPACE="\${voffset $Y}"; fi
      if [[ ! "$X" =~ ^-?[0-9]+$ ]]; then X=0; fi
      if [[ ! "$IY" =~ ^-?[0-9]+$ ]]; then IY=0; fi
      if [[ ! "$IX" =~ ^-?[0-9]+$ ]]; then IX=0; fi
      if [[ ! "$ISIZE" =~ ^[0-9]+$ ]]; then ISIZE=$(LC_NUMERIC=C; printf %.0f $(echo "$SIZE*8/3" | bc -l)); fi

      NSFSIZE="$(LC_NUMERIC=C; printf %.0f $(echo "$SIZE*3/4" | bc -l))"
      SFSIZE=":size=$NSFSIZE"
      TSIZE=$(($ISIZE+$X))
      RESIZE="-resize ${ISIZE}x${ISIZE} "

      if [ "$RIGHT" = "1" ]; then ALIGNMENT="\${alignr $TSIZE}"; else RIGHT="0"; fi

      if [ "$COLOR" ]; then COLOR="-fill $COLOR -colorize 100% "
      elif [ "$HEX" ]; then COLOR="-fill #$HEX -colorize 100% "
      fi
      convert \( $CONKYPATH/weather-icons/$(if [ "$ICON" ]; then echo $ICON; else echo '44'; fi).png $RESIZE -write $FILE-1.png \) \( -clone 0 $COLOR-write $FILE-2.png \) +swap -alpha on -compose copy-opacity -composite $FILE.png

      if [ "$SUMMARY" = "1" ]; then
        echo "\${font $FONT$BBOLD$BFSIZE}\${offset $TSIZE}$ALIGNMENT$CITY, "$(if [ "$CONKYLANG" = "hi" ]; then echo $TEMP | sed 'y/0123456789/०१२३४५६७८९/'; else echo $TEMP; fi)"$UNIT\${font $FONT$SFSIZE}\${color1}"
      fi
      if [ "$TS" = "1" ]; then
         echo "$YSPACE\${offset $TSIZE}$ALIGNMENT${LDATA[1]}"$(if [ "$CONKYLANG" = "hi" ]; then echo $FLTEMP | sed 'y/0123456789/०१२३४५६७८९/'; else echo $FLTEMP; fi)$UNIT
      fi
      if [ "$W" = "1" ]; then
         if [ -z "$WIND" -o "$WIND" = "0" ]; then WIND=${LDATA[4]}; else WIND=$WIND$WUNIT; fi
         echo "$YSPACE\${offset $TSIZE}$ALIGNMENT${LDATA[2]}"$(if [ "$CONKYLANG" = "hi" ]; then echo $WIND | sed 'y/0123456789/०१२३४५६७८९/'; else echo $WIND; fi)
      fi
      if [ "$U" = "1" ]; then
         echo "$YSPACE\${offset $TSIZE}$ALIGNMENT${LDATA[3]}"$(if [ "$UV" ]; then echo $UV; else echo "--"; fi)
      fi
      if [ "$SHOWCOND" = "1" ]; then
         echo "$YSPACE\${font $FONT$BOLD$SFSIZE}\${offset $TSIZE}$ALIGNMENT$COND"
      fi
#      echo '${image '$FILE'.png -p '$IX','$IY'}${voffset -'$SIZE'}'
      echo "\${lua weather_icon $FILE.png $RIGHT $IX $IY}\${voffset -$SIZE}"

   fi

fi
