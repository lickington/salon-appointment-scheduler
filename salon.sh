#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t -A -F"," -c"
echo -e "\n~~~~~ My Salon ~~~~~"
# display numbered menu
MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\nWelcome to the salon, what do you need today? \n"
  echo -e "\n1) cut \n2) color \n3) perm \n4) style \n5) trim"
  # ask for service id from the options
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
  1) APPOINTMENT_SCHEDULER ;;
  2) APPOINTMENT_SCHEDULER ;;
  3) APPOINTMENT_SCHEDULER ;;
  4) APPOINTMENT_SCHEDULER ;;
  5) APPOINTMENT_SCHEDULER ;;
  *) MAIN_MENU "Please enter a valid option." ;;
  esac

} 
APPOINTMENT_SCHEDULER() {
  

echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

CUSTOMER_QUERY_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
echo $CUSTOMER_QUERY_RESULT


if [[ $CUSTOMER_QUERY_RESULT == *"(0 rows)"* ]] || [[ -z $CUSTOMER_QUERY_RESULT ]]; then 
# Customer does not exist 
echo -e "\nI don't have your phone number registered yet, so what's your name?"
read CUSTOMER_NAME 
INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')") 
echo $INSERT_CUSTOMER_RESULT
CUSTOMER_QUERY_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")



else 
# Customer exists 
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'") 

fi
echo -e "\nWhat time would you like your appointment, $CUSTOMER_NAME?" 

read SERVICE_TIME 


  # ask for appointment time
  
echo "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_QUERY_RESULT, $SERVICE_ID_SELECTED, '$SERVICE_TIME')"

  APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_QUERY_RESULT, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
 
}
MAIN_MENU