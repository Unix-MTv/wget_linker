#!/usr/bin/env bash
# required applications: wget, tree
clear
PS3=" --- Wget URL's Linker:"
# Меню, постоянный цикл;
OPTIONS=("wget_link" "list_info" "create_dir" "quit")
select OPT in "${OPTIONS[@]}"
do
	case $OPT in
		"wget_link")
			while [[ "$LINK_NAME" = "" ]]; do
				echo "Как будет называться страница?"
				read -p " - Ввести имя: " 'LINK_NAME'
			done

			while [[ "$DIR" = "" ]]; do
				TREE_DIR="$(tree -d)"
				echo "-----"
				echo "$TREE_DIR"
				echo "-----"
				echo "Указать путь."
				read -p " - Ввести путь: " 'DIR'
			done

			while [[ "$URL" = "" ]]; do
				echo "Указать URL."
				read -p " - Ввести ссылку: " URL
			done

			if [[ -n "${LINK_NAME}" && "${DIR}" && "$URL" ]]; then
				wget -q -p -E --convert-links -np -nd --default-page="${LINK_NAME}" -P "${DIR}" $URL
				# Сбрасываем значения переменных;
				unset LINK_NAME DIR URL
				echo " -- Готово!"
			fi
		;;
		"list_info")
			count_html="$(find . -name *.html | wc -l)"
			count_dir="$(find . -type d | wc -l)"
			count_file="$(find . -type f | wc -l)"
			size_total="$(du -sh)"
			echo "Линков: $count_html | Каталогов: $count_dir | Файлов: $count_file | Общий размер: $size_total"
		;;
		"create_dir")
			while [[ "$CREATE_DIR" = "" ]]; do
				TREE_DIR="$(tree -d)"
				echo "-----"
				echo "$TREE_DIR"
				echo "-----"
				echo "Создать каталог."
				read -p " - Ввести путь или имя: " CREATE_DIR
			done

			if [[ -n "$CREATE_DIR" ]]; then
				mkdir -p "$CREATE_DIR"
				# Сбрасываем значения переменных;
				unset CREATE_DIR
			fi
		;;
		"quit")
			break
		;;
		*) echo " -- Недопустимый вариант!";;
	esac
done
