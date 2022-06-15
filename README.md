# auto-install-osx

Allow the use of the Touch-id for the `sudo` :

exec : `sudo vi /etc/pam.d/sudo` -> add `auth sufficient pam_tid.so` at the first line