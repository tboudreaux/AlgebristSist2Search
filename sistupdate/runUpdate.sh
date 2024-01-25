#!/bin/bash
#
SHARES=("Thomas" "Transfer" "Astronomy" "Documents" "WDTransfer" "Videos" "Music" "Pictures" "Scratch")
for SHARE in "${SHARES[@]}"; do
  sist2 scan $ROOT --threads 4 --incremental --ocr-lang=eng --ocr-images --output /mnt/p/d/Thomas/Search/$SHARE.sist2
  sist2 index --threads 4 --es-insecure-ssl --es-url https://elastic:$ELASTIC_PASSWORD@localhost:9200 --incremental --es-index="documentsindex" /mnt/p/d/Thomas/Search/$SHARE.sist2
done
