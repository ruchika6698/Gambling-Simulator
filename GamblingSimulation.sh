#!/bin/bash -x

echo "-------------------Welcome to Gambling Simulator Program-------------"

#constants
STAKE=100
BET=1
DAYS=20
VALUE=50

#variable
totalStake=0

BetAmount=$STAKE

declare -A Dictionary

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
         totalStake=$(($totalStake-$VALUE))
         Dictionary[$count]=$totalStake
      else
         totalStake=$(($totalStake+$VALUE))
         Dictionary[$count]=$totalStake
      fi
      BetAmount=100
	done
	printf "totalStake: $totalStake \n"
}


#function for maximum and mininmum limit
function Limit()
{
	maxLimit=$(($BetAmount+$BetAmount*50/100))
	minLimit=$(($BetAmount-$BetAmount*50/100))
}

betting
Limit


printf "your Stakes: $totalStake \n"

profitValue=$( betting ${Dictionary[@]} )
lossValue=$( betting ${Dictionary[@]} )

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
