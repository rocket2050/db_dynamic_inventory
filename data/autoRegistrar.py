import sys
import logging
from pyzabbix import ZabbixAPI


stream = logging.StreamHandler(sys.stdout)
stream.setLevel(logging.DEBUG)
log = logging.getLogger('pyzabbix')
log.addHandler(stream)
log.setLevel(logging.DEBUG)

#zapi = ZabbixAPI("http://zabbix/zabbix")
#zapi.login("admin", "zabbix")
zapi = ZabbixAPI("https://monitoring.bigparser.com")
zapi.login("sandeep.rawat", "sandy724")
print("Connected to Zabbix API Version %s" % zapi.api_version())

zapi.action.create(name='SandyTest', eventsource=2, status=0, esc_period=0, filter={"evaltype":0,"conditions": [{"conditiontype": 24,"value": "Linux"}]}, operations=[])
