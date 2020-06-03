function irpsql
    ssh -t $argv[1] 'PGPASSWORD=$(sudo grep /etc/ice/postgresql.yaml -e admin_password | cut -f2 -d" ") psql -d ice -U admin'
end