#!/bin/bash

# Укажите имя файла, который вы хотите прочитать
input_file=$1
outputFile=$2
out_var=$3 #если это условие не пустое outputFile становиться переменной создаваемого скрипта, и получает знак $ в начале

# Проверяем, существует ли файл
if [[ ! -f "$input_file" ]]; then
    echo "Ошибка: Файл '$input_file' не найден."
    exit 1
fi

if [[  -f "$input_file.~" ]]; then
    #echo "Файл найден."
    rm "$input_file.~"
fi

if [[ -n "$3" ]]; then
    outputFile='$'$outputFile # если третий аргумент не пустой то добавляем знак $ к значению $outputFile

fi


echo '# ############### РЕДАКТУРА '$outputFile' ################################'> $input_file.~
if [[ -n "$3" ]]; then
    echo 'if [[ -f '$outputFile' ]]; then'>>$input_file.~ #если $outputFile переменная то проверка без "" ковычек
else
    echo 'if [[ -f "'$outputFile'" ]]; then'>>$input_file.~ #если $outputFile прямой путь к файлу то с "" ковычками

fi


echo '     mv '$outputFile $outputFile'.`date +%s` # муваем файл чтобы сохранить оригинал'  >> $input_file.~
echo 'fi' >> $input_file.~


# Открываем файл для чтения и используем цикл while
while IFS= read -r line; do
    # Обрабатываем каждую строку - в данном примере просто выводим ее
    line1=$(echo -e $line|sed "s/'/\\\\x27/g")
    echo  "echo -e '$line1' >> $outputFile" >> $input_file.~
done < "$input_file"

echo '# ############### КОНЕЦ РЕДАКТУРЫ '$outputFile' ###########################'>> $input_file.~
