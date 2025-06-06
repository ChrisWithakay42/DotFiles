#!/bin/sh

for i in $(seq -w 99 -1 2); do
  folder=$(ls -d ${i}-* 2> /dev/null)
  if [ -n "$folder" ]; then
    new_num=$(printf "%02d" $((10#$i + 1)))
    mv "$folder" "${new_num}-$folder"
  fi
done
