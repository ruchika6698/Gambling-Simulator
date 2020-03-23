#!/bin/bash -x

echo "-------------------Welcome to Gambling Simulator Program-------------"

STAKE=100
BET=1

BetAmount=$STAKE

#Function for bet win or loose
function betting()
{
	Number=$((RANDOM%2))

	if [[ $Number -eq 1 ]]
	then
		echo "you won 1 bet"
		((BetAmount++))
	else
		echo "you loose 1 bet"
		((BetAmount--))
	fi
	echo $BetAmount
}
betting

#function for maximum and mininmum limit 
function Limit()
{
	maxLimit=$(($BetAmount+$BetAmount*50/100))
	minLimit=$(($BetAmount-$BetAmount*50/100))
}
Limit
