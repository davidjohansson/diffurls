#!/usr/bin/env bash

rm -rf out/
while IFS='' read -r line || [[ -n "$line" ]]; do
    read -r -a array <<< "$line"

    OUTDIR=out/"${array[0]}"
    HOST="${array[1]}"
    mkdir -p $OUTDIR

    while IFS='' read -r uriline || [[ -n "$uriline" ]]; do
        read -r -a uriarray <<< "$uriline"

        NAME="${uriarray[0]}"
        URI="${uriarray[1]}"

         echo "saving $HOST/$URI to $OUTDIR/$NAME.json"
         curl $HOST/$URI | python -mjson.tool >> $OUTDIR/$NAME.json
    done < "uris.txt"

done < "hosts.txt"
ksdiff out/local out/stage