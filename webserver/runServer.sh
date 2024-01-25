#!/bin/bash
#
sist2 web --bind 0.0.0.0:4090 --es-url https://elastic:$ELASTIC_PASSWORD@10.17.1.25:9200 --es-insecure-ssl --es-index=documentsindex /mnt/p/d/Thomas/Search/Documents.sist2 /mnt/p/d/Thomas/Search/Thomas.sist2 /mnt/p/d/Thomas/Search/Astronomy.sist2 /mnt/p/d/Thomas/Search/Transfer.sist2
