function dirpsql
    ssh -t $argv[1] 'docker exec -i -t icecore bash -c \'PGPASSWORD=$(grep /etc/ice/postgresql.yaml -e admin_password | cut -f2 -d" ") psql -h /run/postgresql -d ice -U admin\''
end