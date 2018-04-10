# db_dynamic_inventory
I'll show how to implement dynamic inventory in ansible using MySql as backend


## Reference links
* http://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html
* https://www.jeffgeerling.com/blog/creating-custom-dynamic-inventories-ansible


## Setup Instructions
* Setup zabbix server
  * ansible-playbook -i /etc/ansible/inventory.py -e "host=zabbix version=3.2" /etc/ansible/roles/osm_zabbix/site.yml
  * Due to a bug in osm_zabbix you may have to start MySql server in zabbix container  
* Setup Zabbix agent
  * ansible-playbook -i /etc/ansible/inventory.py -e "host=web version=3.2 zabbix_server_ip=zabbix" /etc/ansible/roles/zabbix-agent/agent.yml
