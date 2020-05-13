#!/bin/bash

# Created by cristianovisk
# Github https://github.com/cristianovisk
# Site https://cristianovisk.github.io

function moveMail {
    for email in `zmprov -l gaa | grep $domain`;
    do
        for msgid in `zmmailbox -z -m "$email" s -l 999 -t message "in:$fOrig subject: $subject" | grep mess | awk '{print $2}'`;
            do
                echo "Msg from $email, is moved for Inbox folder - MsgID: $msgid"   
                zmmailbox -z -m "$email" mm $msgid $fDest;
            done;
    done
}

if [ $# -lt 8 ];
then
    echo -e "Your command line contains $# arguments\nNeed:\n-domain domain.com.br\n-subject word_in_subject_to_search\n-fOrig Junk\n-fDest Inbox"
elif [ $# -lt 1 ];
then
    echo "Your command line contains no arguments\nNeed:\n-domain domain.com.br\n-subject word_in_subject_to_search\n-fOrig Junk\n-fDest Inbox"
elif [ $# -eq 8 ];
then
    array=($@)
    for arg in {0..8};
    do
        if [[ ${array[$arg]} == '-domain' ]];then
            domain=${array[$arg+1]};
        elif [[ ${array[$arg]} == '-subject' ]];then
            subject=${array[$arg+1]};
        elif [[ ${array[$arg]} == '-fOrig' || ${array[$arg]} == '-forig' ]];then
            fOrig=${array[$arg+1]};
        elif [[ ${array[$arg]} == '-fDest' || ${array[$arg]} == '-fdest' ]];then
            fDest=${array[$arg+1]};
        fi
    done
    echo -e "Domain: $domain\nSubject: $subject\nFolder Orig: $fOrig\nFolder Dest: $fDest"
    echo -e "-------\nYou confirm the informations above ?\n1) Yes\n2) No"
    read op
    if [ $op -eq 1 ];
    then
        echo "Moving you e-mails... wait and drink a coffee!"
        moveMail
    elif [ $op -eq 2 ];
    then
        echo "Exiting script..."
        exit;
    else
        echo "Chose wrong...";
    fi
fi