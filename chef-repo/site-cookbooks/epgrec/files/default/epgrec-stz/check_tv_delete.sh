#!/bin/sh

from="admin@sky-apart.com"
to="kuniiskywalker@gmail.com"
srt=""
destination="/home/share/tv/tmp/"

for f in $(find /home/share/tv -maxdepth 1 -mtime +20 -type f); do
  # echo $f
  # echo $(basename $f)
  srt="${srt}・$(basename $f)\n\n"
  mv ${f} ${destination}
done

send_mail() {
    from=$1
    to=$2
    inputEncoding="utf-8"
    outputEncoding="iso-2022-jp"
    subjectHead="=?${outputEncoding}?B?"
    subjectBody="`echo "$3" | iconv -f ${inputEncoding} -t ${outputEncoding} | base64 | tr -d '\n'`"
    subjectTail="?="
    subject=${subjectHead}${subjectBody}${subjectTail}
    contents="`echo -e $4 | iconv -f ${inputEncoding} -t ${outputEncoding}`"
    echo "$contents" | mail -s "$subject" "$to" -- -f "$from"
    return $?
}

subject="明日以下の録画内容が消去されます"

if [ $srt ]; then
  send_mail "$from" "$to" "$subject" "$srt"
  exit 1
fi

if [ $? -eq 1 ]; then
    echo "send mail failure"
    exit 1
fi