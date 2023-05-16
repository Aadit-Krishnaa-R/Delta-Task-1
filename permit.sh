#changing the group of Hostels to HAD so HAD can view all files inside
for i in GarnetA GarnetB Opal; do
    sudo chgrp HAD /home/$i
    chmod g=rwx /home/$i
    # adding HAD and respective hostel warden into a group which can access the home directories of all students
    sudo groupadd -f ${i}OWN
    sudo usermod -aG ${i}OWN $i
    sudo usermod -aG ${i}OWN HAD

done
sudo cp ./mess.txt /home/HAD/mess.txt
#Giving HAD permission to home directory of all students and respective hostel warden the access to their student home directories
cat studentDetails.txt | while read -r -a line;
do 
    Name=${line[0]}
    Rollno=${line[1]}
    Hostel=${line[2]}
    Room=${line[3]}
    Mess=${line[4]}
    MessPref=${line[5]}
    sudo chgrp ${Hostel}OWN /home/$Name
    sudo chmod g=rwx /home/$Name
    sudo cp ./mess.txt /home/$Name/mess.txt

done