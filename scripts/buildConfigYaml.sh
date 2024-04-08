#!/bin/bash

version=2024040501

ingestion_key="$1"
hostname="$2"
tags="$3"
logs="$4"

if [[ ${ingestion_key} == "" || ${hostname} == "" || ${logs} == "" ]]; then
    echo -e "Issue:\nnot all parameters were provided\n $0 \"ingestion_key\" \"hostname\" \"tags\" \"logs,separated\""
fi

fileExt=()

echo "http:" > /etc/logdna/config.yaml
echo "  host: logs.logdna.com" >> /etc/logdna/config.yaml
echo "  endpoint: /logs/agent" >> /etc/logdna/config.yaml
echo "  use_ssl: true" >> /etc/logdna/config.yaml
echo "  timeout: 10000" >> /etc/logdna/config.yaml
echo "  use_compression: true" >> /etc/logdna/config.yaml
echo "  gzip_level: 2" >> /etc/logdna/config.yaml
echo "  ingestion_key: ${ingestion_key}" >> /etc/logdna/config.yaml
echo "  params:" >> /etc/logdna/config.yaml
echo "    hostname: ${hostname}" >> /etc/logdna/config.yaml
echo "    mac: null" >> /etc/logdna/config.yaml
echo "    ip: null" >> /etc/logdna/config.yaml

tags_=""
delim=""
for tag in $( echo $tags ); do
    tags_="$tags_$delim$tag"; delim=","
done;

echo "    tags: ${tags_}" >> /etc/logdna/config.yaml
echo "  body_size: 2097152" >> /etc/logdna/config.yaml
echo "  retry_dir: /tmp/logdna" >> /etc/logdna/config.yaml
echo "log:" >> /etc/logdna/config.yaml
echo "  dirs:" >> /etc/logdna/config.yaml

for log in $(echo ${logs//,/$IFS}); do
    if [ -d "${log}" ]; then
        echo "  - $log" >> /etc/logdna/config.yaml
    fi
    if [ -f "${log}" ]; then 
        echo "  - $(dirname ${log})" >> /etc/logdna/config.yaml
        ext=$(basename ${log} | awk -F. '{print $NF}')
        echo ${fileExt[@]} | grep -q $ext;
        if [ $? -ne 0 ]; then
            fileExt+=$ext;
        fi
    fi
done;

echo "  include:" >> /etc/logdna/config.yaml
echo "    glob:" >> /etc/logdna/config.yaml
echo "    - '*.log'" >> /etc/logdna/config.yaml

for ext in ${fileExt[@]}; do
    echo "    - '*.${ext}'" >> /etc/logdna/config.yaml
done;

echo "    regex: []" >> /etc/logdna/config.yaml
echo "  exclude:" >> /etc/logdna/config.yaml
echo "    glob:" >> /etc/logdna/config.yaml
echo "    - /var/log/wtmp" >> /etc/logdna/config.yaml
echo "    - /var/log/btmp" >> /etc/logdna/config.yaml
echo "    - /var/log/utmp" >> /etc/logdna/config.yaml
echo "    - /var/log/wtmpx" >> /etc/logdna/config.yaml
echo "    - /var/log/btmpx" >> /etc/logdna/config.yaml
echo "    - /var/log/utmpx" >> /etc/logdna/config.yaml
echo "    - /var/log/asl/**" >> /etc/logdna/config.yaml
echo "    - /var/log/sa/**" >> /etc/logdna/config.yaml
echo "    - /var/log/sar*" >> /etc/logdna/config.yaml
echo "    - /var/log/tallylog" >> /etc/logdna/config.yaml
echo "    - /var/log/fluentd-buffers/**/*" >> /etc/logdna/config.yaml
echo "    - /var/log/pods/**/*" >> /etc/logdna/config.yaml
echo "    regex: []" >> /etc/logdna/config.yaml
echo "  log_metric_server_stats: null" >> /etc/logdna/config.yaml
echo "  clear_cache_interval: 21600" >> /etc/logdna/config.yaml
echo "  metadata_retry_delay: 0" >> /etc/logdna/config.yaml
echo "journald:" >> /etc/logdna/config.yaml
echo "  systemd_journal_tailer: false" >> /etc/logdna/config.yaml
