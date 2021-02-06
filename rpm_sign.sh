#!/usr/bin/expect -f

lassign $argv file password

spawn rpm --addsign $file
expect -re "Enter pass *phrase: *"
send -- "$password\r"
expect eof
