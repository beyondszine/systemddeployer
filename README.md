# systemddeployer
script for making executable systemd enabled.


This script aims to enable any executable program to systemD.  Just pass the desired executable file name as parameter 
& get it added as a system service.  All systemD commands can obviously be accessed via command line.

Note:  You will have to use sudo in order to move the file to default systemD directory & enable it via systemD.

Example:
sudo ./systemddeployer.sh -s "TestService" -f "/home/beyond/github/systemddeployer/try.sh" -d "this is my description. It will keep on printing in some file" -t "multi-user.target"
