#!/usr/bin/env python

from ansible.inventory.ini import InventoryParser
import json
import os

# Import static hosts file for inventory.
file_path = os.path.dirname(os.path.realpath(__file__))
static_file = os.path.join(file_path, "hosts")

inv = { '_meta': { 'hostvars': {}}}
parser = InventoryParser(filename=static_file)
for group in parser.groups.values():
    group_dict = inv.setdefault(group.name, {})
    group_vars = group_dict.setdefault('vars', {})
    group_children = group_dict.setdefault('children', [])
    group_hosts = group_dict.setdefault('hosts', [])
    for var in group.vars:
        group_vars[var] = group.vars[var]
    for child in group.child_groups:
        group_children.append(child.name)
    for host in group.hosts:
        group_hosts.append(host.name)
        host_vars = inv['_meta']['hostvars'].setdefault(host.name, {});
        for var in host.vars:
            host_vars[var] = host.vars[var]

print json.dumps(inv, indent=4)