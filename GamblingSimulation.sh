#!/bin/bash -x

echo "-------------------Welcome to Gambling Simulator Program-------------"

#constants
STAKE=100
BET=1
DAYS=20
VALUE=50

#variable
totalStake=0
maxLimit=0
minLimit=0

declare -A Dictionary
BetAmount=$STAKE

maxLimit=$(($BetAmount+$BetAmount*50/100))
minLimit=$(($BetAmount-$BetAmount*50/100))


#Function for bet win or loose
function betting()
{
	for (( count=1; count<=$DAYS; count++ ))
	do
		while [[ $BetAmount -ne 0 ]]
		do
			Number=$((RANDOM%2))
			if [[ $Number -eq 1 ]]
			then
	    		((BetAmount++))
	    		if [[ $BetAmount -eq $maxLimit ]]
	    		then
					break
        		fi
			else
				((BetAmount--))
				if [[ $BetAmount -eq $minLimit ]]
				then
					break
				fi
			fi
		done
		if [[ $BetAmount -eq $minLimit ]]
		then
			totalStake=$(( $totalStake-$VALUE ))
			Dictionary[$count]=$totalStake
		else
			totalStake=$(( $totalStake+$VALUE ))
			Dictionary[$count]=$totalStake
		fi
	done
	printf "totalStake: $totalStake \n"
}

#Function for day lucky or unlucky
function luckydayornot()
{
	printf "your Stakes: $totalStake \n"

	profitValue=$(printf "%s\n" ${Dictionary[@]} | sort -n | tail -1 )
	lossValue=$(printf "%s\n" ${Dictionary[@]} | sort -n | head -1 )

	printf "profitValue: $profitValue \n"
	printf "lossValue :$lossValue \n"

	printf "day: ${!Dictionary[@]}"
	printf "stake: ${Dictionary[@]}"

	for key in ${!Dictionary[@]}
	do
		if [[ ${Dictionary[$key]} -eq $profitValue ]]
		then
			printf "lucky day :$key \n"
		fi

		if [[ ${Dictionary[$key]} -eq $lossValue ]]
		then
			printf "unlucky day :$key \n"
		fi
	done
}

betting
luckydayornot

#if won would like to continue or not
if [ $totalStake -gt 0 ]
then
	read -p "do you want to countinue 1.Yes 2.No :" toCountinue
	if [ $toCountinue -eq 1 ]
	then
		betting
		luckydayornot
	else
		printf "Game Over \n"
	fi
fi
