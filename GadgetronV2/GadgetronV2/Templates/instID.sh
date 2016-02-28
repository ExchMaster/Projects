iid=$(hostname | cut -f 2 -d "-")
pip=$(ip addr | grep 'state UP' -A2 | tail -n 1 | awk '{print $2}' | cut -f 1 -d '/')
echo $iid > /$pip
