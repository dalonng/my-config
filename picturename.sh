#!/bin/sh
counter=1
root=mypict
resolution=400x300
for i in "$(ls -1 $1/*.jpg)"; do
  echo "Now working on $i"
  convert -resize $resolution $i ${root}_${counter}.jpg
  counter=$(expr $counter + 1)
done
