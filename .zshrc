
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"

setopt PROMPT_SUBST
PROMPT2="hi"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

plugins=(emoji git golang node heroku docker redis-cli xcode yarn gcloud kubectx asdf globalias)

source $ZSH/oh-my-zsh.sh


src() {
	echo 'Reloading\n'
	source ~/.zshrc
}

alias c='clear'

# User configuration

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

cd() {
        DIR=$1
        if [ -z $DIR ];
                then DIR=$HOME
        fi
        builtin cd "$DIR" && ls -a;
}

alias la="ls -a"
alias lla="ls -la"

mcd() {
    mkdir -p "$1"; builtin cd "$1";
}
alias mkdir="mkdir -p"

#[ -f ~/.hoy_aliases ] && source ~/.hoy_aliases
[ -f ~/.tw_kubectl_aliases ] && source ~/.tw_kubectl_aliases

alias gopath='cd ~/Projects/Gopath/src'
alias web='cd ~/Websites'
alias projects='cd ~/Projects'
hash -d p=~/Projects

alias getmp3='youtube-dl -x --audio-format mp3'

alias gin='gin -i --notifications -p 3099'

alias stash='git stash'
alias pop='git stash pop'
alias gs='git status -sb'
alias gst='git status'
alias gcm='git checkout master'
alias gupalldirs='find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull --rebase \;'

flushdns() {
    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
}

serve() {
    http-server -p ${1:-4000}
}

alias q='echo Not a command, you dang fool'
alias d=q
alias timer='while true; do date; sleep 1; done;'

alias -g A='| ack '
alias a='alias | ack '
alias H='history'

export PATH=~/.bin:$PATH

#export GOROOT=/usr/local/opt/go@1.15/libexec
#export PATH=$PATH:$GOROOT/bin

export PATH=/usr/local/opt/ruby/bin:$HOME/.gem/ruby/2.6.0/bin:$PATH
export PATH="$PATH:/usr/local/lib/ruby/gems/2.7.0/bin"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias chrome_debug='open -n -a Chromium --args --disable-web-security --user-data-dir="$HOME/Library/Application Support/Chromium/Insecure_Mode"'

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets

alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1

alias localip='ifconfig en0 | grep inet | grep -v inet6'

  # ii:  display useful host related informaton
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }


source ~/.scripts/.make_github_pull_request_completion.sh
# Install as a bin from scripts: cd .scripts; install make_github_pull_request.sh ~/.bin/make_github_pull_request
alias pr=make_github_pull_request


finder_clear_recents() {
	defaults delete com.apple.finder GoToField
	defaults delete com.apple.finder GoToFieldHistory
}

CLOUDSDK_PYTHON=/usr/local/bin/python3.10

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; else echo 'no google-cloud-sdk'; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi


#export GOPATH=$HOME/Projects/Gopath
#resetgopath() {
#	export GOPATH=$HOME/Projects/Gopath
#}

#setgo17() {
#	gvm use go1.17.13
#	resetgopath
#}
#
#setgo15() {
#	gvm use go1.15.15
#	resetgopath
#}
#
#
#setgo18() {
#	gvm use go1.18.10
#	resetgopath
#}
#
#setgo21() {
#	gvm use go1.21.5
#	resetgopath
#}

. ~/.asdf/plugins/golang/set-env.zsh

#export PATH="$GOPATH/bin:$PATH"

scripts() {
	if [ -f 'package.json' ]; then 
		jq '.scripts' package.json
	else 
		echo "no package.json";
	fi
}

[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

setenvfromyml() {
	while read assign; do
	export "$assign"; 
	done < <(sed -nr '/env_variables:/,$ s/  ([A-Z_]+): (.*)/\1=\2/ p' $1)
}

viewmd() {
	pandoc $1 | lynx -stdin
}

tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

eval "$(zoxide init zsh)"
