#!/bin/sh
echo "CHANNEL : $CHANNEL"
echo "DURATION: $DURATION"
echo "OUTPUT  : $OUTPUT"
echo "TUNER : $TUNER"
echo "TYPE : $TYPE"
echo "MODE : $MODE"
echo "SID  : $SID"

RECORDER=/usr/local/bin/recpt1

if [ ${MODE} = 0 ]; then
   # MODE=0では必ず無加工のTSを吐き出すこと
   $RECORDER --b25 --strip --sid epg $CHANNEL $DURATION ${OUTPUT} >/dev/null
elif [ ${MODE} = 1 ]; then
   # 目的のSIDのみ残す
   $RECORDER --b25 --strip --sid $SID $CHANNEL $DURATION ${OUTPUT} >/dev/null
# mode 2 example is as follows
#elif [ ${MODE} = 2 ]; then
#   $RECORDER $CHANNEL $DURATION ${OUTPUT}.tmp.ts --b25 --strip
#   ffmpeg -i ${OUTPUT}.tmp.ts ... 適当なオプション ${OUTPUT}
fi
