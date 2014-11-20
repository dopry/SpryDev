# VirtualBox Shared Folders and hosts.py

Virtual Box shared folders on windows hosts are presented in the guest as
mode 777. Ansible treats any inventory with the execute bit set as executable.
Hosts.py reads the static ini and presents it to ansible. If you wish to
incorporate additional dynamic inventory you can modify or replace hosts.py.
