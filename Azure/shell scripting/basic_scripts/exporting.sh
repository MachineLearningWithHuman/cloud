#!/bin/sh
echo "What is your name?"
read USER_NAME
echo "Hello $USER_NAME"
echo "I will create you a file called $USER_NAME_file"
touch $USER_NAME_file

nano $USER_NAME_file

for i in 1 2 3 4 5
do
  echo "Looping ... number $i"
done


