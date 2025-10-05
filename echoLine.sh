#!/bin/bash

# Укажите имя файла, который вы хотите прочитать
input_file=$1
outputFile=$2

# Проверяем, существует ли файл
if [[ ! -f "$input_file" ]]; then
    echo "Ошибка: Файл '$input_file' не найден."
    exit 1
fi

if [[  -f "$input_file.~" ]]; then
    #echo "Файл найден."
    rm "$input_file.~"
fi




echo '# ############### РЕДАКТУРА '$outputFile' ################################'> $input_file.~
echo 'if [[ -f "'$outputFile'" ]]; then'>>$input_file.~

echo '     mv '$outputFile $outputFile'.`date +%s` # муваем файл чтобы сохранить оригинал'  >> $input_file.~
echo 'fi' >> $input_file.~


# Открываем файл для чтения и используем цикл while
while IFS= read -r line; do
    # Обрабатываем каждую строку - в данном примере просто выводим ее
    echo -e "echo -e '$line' >> $outputFile" >> $input_file.~
done < "$input_file"

echo '# ############### КОНЕЦ РЕДАКТУРЫ '$outputFile' ###########################'>> $input_file.~
