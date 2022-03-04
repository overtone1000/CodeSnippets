#!/bin/bash

ME="$(basename ${0})"
echo "Running script ${ME}"

for FILE in *
do
	if [ "${FILE}" == "${ME}" ];
	then
		echo "Skipping the script file."
	else
		if [ -d "${FILE}" ]; #If it is a directory...
		then
			echo "Skipping directory ${FILE}"
		else
			FILENAME_NOEXT=$(echo "${FILE}" | cut -f 1 -d '.') #remove file extension
			FILENAME_NOEXT_NOSPACE="${FILENAME_NOEXT//[ ]/_}" #get rid of spaces
			NEWFILENAME="${FILENAME_NOEXT_NOSPACE}.txt"
			if [ "${NEWFILENAME}" == "${FILE}" ];
			then
				NEWFILENAME="${FILENAME_NOEXT_NOSPACE}_converted.txt"
			fi
			echo "Converting ${FILE} to dokuwiki format as ${FILENAME}.txt"
			pandoc -t dokuwiki -o "${NEWFILENAME}.txt" "${FILE}"
		fi
	fi
done
