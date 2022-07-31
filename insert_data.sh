#! /bin/bash

if [[ $1 == "test" ]]; then
    PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
    PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo "$($PSQL "TRUNCATE teams, games")"
cat games_test.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS; do
    if [[ $YEAR != 'year' ]]; then
        #add each team to teams table
        #I'll do the winner first
        INSERT_WINNER=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')")
        if [[ $INSERT_WINNER == 'INSERT 0 1' ]]; then
            echo Added $WINNER
        #Below is not working with or without %
        #elif [[ $INSERT_WINNER == "ERROR:  duplicate key value violates unique constraint "teams_name_key"" ]]
        #then echo $WINNER has already been added
        fi
        INSERT_OPPONENT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT')")
        if [[ $INSERT_OPPONENT == 'INSERT 0 1' ]]; then
            echo $OPPONENT added
        fi

    fi

done