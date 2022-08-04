#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

# START Input the argument number, symbol or name
 MAIN() {
          echo -e "Please provide an element as an argument."
 }
#  search the element by name
          BY_NAME() {
          RESULT_BY_NAME=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types USING(type_id) WHERE elements.name = '$NAME_ARGUMENT'")
          echo $RESULT_BY_NAME | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE_NAME
          do
          # if no arugument
          if [[  -z $RESULT_BY_NAME  ]]
           then
           echo "I could not find that element in the database."
           # if find the name of element
           else
           echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
         fi
         done
        }
        # search the element by nuber
        BY_ATOMIC_NUMBER() {
         RESULT_BY_NUMBER=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types USING(type_id) WHERE elements.atomic_number = $ATOMIC_NUMBER_ARGUMENT")  
         echo $RESULT_BY_NUMBER | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE_NAME
         do
         # if no arugument
         if [[  -z $RESULT_BY_NUMBER  ]]
           then
           echo "I could not find that element in the database."
           #find the element by number
           else
           echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
         fi
         done
      }
      # search the element by symbol
      BY_SYMBOL() {

        RESULT_BY_SYMBOL=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, types.type FROM elements INNER JOIN properties ON elements.atomic_number = properties.atomic_number INNER JOIN types USING(type_id) WHERE elements.symbol ='$SYMBOL_ARGUMENT'")
        echo $RESULT_BY_SYMBOL | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE_NAME
         do
         if [[  -z $RESULT_BY_SYMBOL  ]]
         # if no arugument
           then
             echo "I could not find that element in the database."
             # find the element by symbol
            else
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_NAME, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
         fi
        done
            }

         if [[ -z $1 ]]
           then
           MAIN
         fi
         if [[ $1 =~ ^[0-9]+$ ]]
           then
           ATOMIC_NUMBER_ARGUMENT=$1
           BY_ATOMIC_NUMBER
         fi
         if [[ $1 =~ ^[a-zA-Z]+$ ]]
           then
            if [[ ${#1} -le 2 ]]
             then
              SYMBOL_ARGUMENT=$1
              BY_SYMBOL
             else
              NAME_ARGUMENT=$1
              BY_NAME
            fi
         fi