#!/usr/bin/env bash

ssh_ip()
{
	HOST="$1"
	if [[ "$HOST" == "" ]]; then
		return
	fi

	SEARCH="$(cat ~/.ssh/config | grep "Host $HOST" -A 1)"
	SPLIT="$(cut -d ' ' -f2 <<<"$SEARCH")"
	IP="$(tail -n 1 <<<"$SPLIT")"
	if [[ "$IP" == "" ]]; then
		return
	else
		echo "$IP"
	fi
}

_ssh_completions()
{
	HOSTS="$(cat ~/.ssh/config | grep 'Host ')"
	SPLIT="$(cut -d ' ' -f2 <<< "$HOSTS")"
	COMPREPLY=($(compgen -W "$SPLIT" "${COMP_WORDS[1]}"))
}

complete -F _ssh_completions ssh
complete -F _ssh_completions ssh_ip
