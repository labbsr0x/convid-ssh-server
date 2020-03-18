#!/bin/sh

read password
echo "PAM_RHOST $PAM_RHOST"
echo "PAM_RUSER $PAM_RUSER"  
echo "PAM_SERVICE $PAM_SERVICE"  
echo "PAM_TTY $PAM_TTY"  
echo "PAM_USER $PAM_USER"  
echo "PAM_TYPE $PAM_TYPE"
echo "password $password"

exit 1
