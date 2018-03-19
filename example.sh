#!/bin/env bash
set -ex
# constants
URL="http://127.0.0.1:5000"
SINGLE_CHARACTERS=("21¤!" "23¤#" "24¤$" "26¤&" "27¤'" "2A¤\*" "2B¤+" "2C¤," "2F¤/" "3A¤:" "3B¤;" "3D¤=" "3F¤?" "40¤@" "20¤_" "22¤\\\\\"" "25¤%" "2D¤-" "2E¤.")
DUAL_CHARACTERS=("28:(:29:)" "5B:\[:5D:]" "3C:<:3E:>" "7B:{:7D:}")
# functions
function main (){
	curl ${URL}/test/dummiest
	curl ${URL}"/test/dummiest?foo=bar"
	# each verb
	for verb in "PUT" "GET" "DELETE" "POST"; do
		
		# each parameter single reserved character (ie http://...?foo*fum=bar)
		for reservedCharacters in ${SINGLE_CHARACTERS[@]}; do
			testRequestParameterSingleReserved ${reservedCharacters}
		done
		# each parameter dual reserved character (ie http://...?foo[fum]=bar)
		for dualCharacters in ${DUAL_CHARACTERS[@]}; do
			testRequestParameterDualReserved ${dualCharacters}
		done
		# each member single reserved character (ie http://.../foo*fum)
		for reservedCharacters in ${SINGLE_CHARACTERS[@]}; do
			[[ ${reservedCharacters} != *"/"* ]] && testRequestMemberSingleReserved ${reservedCharacters}
		done
		# each parameter dual reserved character (ie http://.../foo[fum])
		for dualCharacters in ${DUAL_CHARACTERS[@]}; do
			testRequestMemberDualReserved ${dualCharacters}
		done
	done
}
function testRequestParameterSingleReserved(){
	inputCharacters=$1
	splittedCharacters=(${inputCharacters//¤/ })
	result=`curl -i -X ${verb} ${URL}"/test/dummiest?foo%"${splittedCharacters[0]}"fum=bar"`
	[[ ${splittedCharacters[1]} = "_" ]] && splittedCharacters[1]=" "
	if [[ $result != *"200 OK"*"foo"${splittedCharacters[1]}"fum"*"bar"* ]]; then
		echo "ERROR : response is not correct"
		exit 1
	fi
}
function testRequestParameterDualReserved(){
	inputCharacters=$1
	splittedCharacters=(${inputCharacters//:/ })
	result=`curl -i -X ${verb} ${URL}"/test/dummiest?foo%"${splittedCharacters[0]}"fum%"${splittedCharacters[2]}"=bar"`
	if [[ $result != *"200 OK"*"foo"${splittedCharacters[1]}"fum"${splittedCharacters[3]}*"bar"* ]]; then
		echo "ERROR : response is not correct"
		exit 1
	fi
}
function testRequestMemberSingleReserved(){
	inputCharacters=$1
	splittedCharacters=(${inputCharacters//¤/ })
	result=`curl -i -X ${verb} ${URL}"/test/dummiest/foo%"${splittedCharacters[0]}"fum"`
	[[ ${splittedCharacters[1]} = "_" ]] && splittedCharacters[1]=" "
	if [[ $result != *"200 OK"*"foo"${splittedCharacters[1]}"fum"* ]]; then
		echo "ERROR : response is not correct"
		exit 1
	fi
}
function testRequestMemberDualReserved(){
	inputCharacters=$1
	splittedCharacters=(${inputCharacters//:/ })
	result=`curl -i -X ${verb} ${URL}"/test/dummiest/foo%"${splittedCharacters[0]}"fum%"${splittedCharacters[2]}`
	if [[ $result != *"200 OK"*"foo"${splittedCharacters[1]}"fum"${splittedCharacters[3]}*"bar"* ]]; then
		echo "ERROR : response is not correct"
		exit 1
	fi
}
# run
main
exit 0
