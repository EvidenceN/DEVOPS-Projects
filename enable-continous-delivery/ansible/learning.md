Create new document and add stuff to it.

```touch inventory
echo [all] > inventory```

## Get list of instances and pipe them to inventory document

```
aws ec2 describe-instances \
\
        --query 'Reservations[*].Instances[*].PublicIpAddress' \
      --filters "Name=tag:Project,Values=Udacity" \
      --output text >> inventory```



## Ansible playbook file structure 

.
├── main-remote.yml     # Playbook file. 
└── roles
 └── setup
     ├── files
     │   └── index.js
     └── tasks
         └── main.yml


## Execute Ansible Command

       # Assuming the udacity.pem and inventory files are present in the current directory

`ansible-playbook main-remote.yml -i inventory --private-key udacity.pem`

