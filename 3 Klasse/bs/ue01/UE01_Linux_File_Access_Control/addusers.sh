#!/bin/bash
# addusers.sh
#

# print all executed commands to the terminal (used for debugging):
set -x


mkdir -p /home/heroesNN
# tbd: fill in the commands for the remaining users


groupadd heroesNN
# tbd: fill in the commands for the remaining users

useradd adminNN -c "User Example" -g  villains -d /home/heroesNN/adminNN -m -s /bin/bash
# tbd: fill in the commands for the remaining users


  
