#!/bin/bash
_make_github_pull_request_completions()
{
#set -x
	local branches=($(compgen -W "$(git branch -r | sed  's/origin\///g' | sed 's/HEAD//g' | sed 's/->//g' )" -- "${COMP_WORDS[1]}"))

	COMPREPLY=("${branches[@]}")

}

complete -F _make_github_pull_request_completions make_github_pull_request
