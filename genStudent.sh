file="/home/HAD"
#create users for hostels
for i in GarnetA GarnetB Agate Opal; do  
    #making directories in /home/HAD so HAD can access files
    sudo mkdir ${file}/$i
    sudo useradd -s /bin/bash -d /home/$i -m $i
    #making the announcements file inside HAD
    sudo touch ${file}/$i/announcements.txt
    sudo touch ${file}/$i/feeDefaulters.txt
    #copying it to Hostel directory so warden can access it
    sudo cp ${file}/$i/announcements.txt /home/$i/announcements.txt
    sudo cp ${file}/$i/feeDefaulters.txt /home/$i/feeDefaulters.txt
done

cat studentDetails.txt | while read -r -a line;
do 
    Name=${line[0]}
    Rollno=${line[1]}
    Hostel=${line[2]}
    Room=${line[3]}
    Mess=${line[4]}
    MessPref=${line[5]}
    if [[ $Rollno == 1021* ]]
    then
    dept=Chemical
    elif [[ $Rollno == 1031* ]]
    then 
    dept=Civil
    elif [[ $Rollno == 1061* ]]
    then
    dept=CS
    elif [[ $Rollno == 1071* ]]
    then
    dept=EEE
    elif [[ $Rollno == 1081* ]]
    then 
    dept=ECE
    elif [[ $Rollno == 1101* ]]
    then 
    dept=ICE
    elif [[ $Rollno == 1111* ]]
    then
    dept=Mech
    elif [[ $Rollno == 1121* ]]
    then
    dept=Meta
    else
    dept=Prod
    fi
    sudo useradd -s /bin/bash -d /home/$Name -m $Name
    #Making Directories inside /home/HAD/Hostel so HAD can view all directories
    mkdir -p ${file}/$Hostel/$Room/$Name
    #Making Directories inside /home/Hostel so HostelWarden can view
    mkdir -p /home/$Hostel/$Room/$Name
    #creating the userdetails
    sudo touch ${file}/$Hostel/$Room/$Name/userdetails.txt
    #Copying the userdetails to Hostel Account and Student Account
    echo "$Name $Rollno $dept First Year $Hostel $Mess $Messpref" | cat >> ${file}/$Hostel/$Room/$Name/userdetails.txt
    sudo cp ${file}/$Hostel/$Room/$Name/userdetails.txt /home/$Hostel/$Room/$Name/userdetails.txt
    sudo cp ${file}/$Hostel/$Room/$Name/userdetails.txt /home/$Name/userdetails.txt
    sudo cp ${file}/$Hostel/announcements.txt /home/$Name/announcements.txt
    sudo cp ${file}/$Hostel/feeDefaulters.txt /home/$Name/feeDefaulters.txt
done