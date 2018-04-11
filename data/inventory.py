#!/usr/bin/env python

import os
import sys
import argparse
import MySQLdb

try:
    import json
except ImportError:
    import simplejson as json

class DBInventory(object):

    def __init__(self):
        self.db = MySQLdb.connect(host="inventory-db",  # your host
                             user="root",       # username
                             passwd="root",     # password
                             db="inventory")   # name of the database
        self.inventory = {}
        self.read_cli_args()

        # Called with `--list`.
        if self.args.list:
            self.build_inventory()
        # Called with `--host [hostname]`.
        elif self.args.host:
            # Not implemented, since we return _meta info `--list`.
            self.build_empty_inventory()
        # If no groups or vars are present, return an empty inventory.
        else:
            self.build_empty_inventory()

        print json.dumps(self.inventory);

    def _addGroupEntries(self, groupIdentifier):
        cur = self.db.cursor()

        hostList=[]
        cur.execute("SELECT * FROM inventory where " + groupIdentifier +"='1'")
        for row in cur.fetchall() :
          hostList.append(row[0])

        groupMapping={}
        groupMapping["hosts"]=hostList

        groupMapping["vars"]={}
        groupMapping["vars"]["redis_monitoring"]=1
        self.inventory[groupIdentifier]=groupMapping

    # Example inventory for testing.
    def build_inventory(self):
        self.inventory = {'_meta': {'hostvars': {}}}

        self._addGroupEntries("web")
        self._addGroupEntries("db")
        self._addGroupEntries("app")
        self._addGroupEntries("other")

    # Empty inventory for testing.
    def build_empty_inventory(self):
        return {'_meta': {'hostvars': {}}}

    # Read the command line args passed to the script.
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action = 'store_true')
        parser.add_argument('--host', action = 'store')
        self.args = parser.parse_args()

# Get the inventory.
DBInventory()
