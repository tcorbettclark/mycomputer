function rpsql
    ssh $argv[1] 'PGPASSWORD=$(sudo grep /etc/ice/postgresql.yaml -e admin_password | cut -f2 -d" ") psql -q -d ice -U admin -f -'
end