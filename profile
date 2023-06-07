# This file is read each time a login shell is started.
# All other interactive shells will only read .bashrc; this is particularly
# important for language settings, see below.

test -z "$PROFILEREAD" && . /etc/profile

# Most applications support several languages for their output.
# To make use of this feature, simply uncomment one of the lines below or
# add your own one (see /usr/share/locale/locale.alias for more codes)
#
#export LANG=de_DE@euro     # uncomment this line for German output
#export LANG=fr_FR@euro     # uncomment this line for French output
#export LANG=es_ES@euro     # uncomment this line for Spanish output


# Some people don't like fortune. If you uncomment the following lines,
# you will have a fortune each time you log in ;-)

if [ -x /usr/bin/fortune ] ; then
    echo
    /usr/bin/fortune
    echo
fi
#
# $HOME/.profile (works with sh, ksh and bash)
#
PATH=`echo $PATH |sed s/::/:/`
if `echo $PATH |grep /usr/local/bin >>/dev/null`
then
:
else
export PATH=/usr/local/bin/:$PATH
fi
: first determine how to suppress a newline on an echo command.
ret=`echo "\c"`
if [ "x$ret" != "x" ]
then
	n='-n';c=''
else
	n='';c='\c'
fi
if [ -x /bin/uname ]
then
	HOSTNAME=`uname -n`
elif [ -x /bin/hostname ]
then
	THOSTNAME=`uname -n`
	HOSTNAME=`basename ${THOSTNAME} .limerick.chicago.il.us`
else
HOSTNAME="unknown"
fi
export HOSTNAME
#ARCH=`arch`
if [ "${ARCH}" = "" ]
then
	ARCH=`uname -m`
fi
# myaddpath function
myaddpath()
{
	if [ -d ${1}  ]
	then
	    if `echo $PATH |egrep "${1}" >>/dev/null`
	    then
	    :
	    else
		PATH=${PATH}:${1}
	    fi
	fi
}

#PATH=$HOME/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/X11/bin:/usr/contrib/bin:/usr/contrib/mh/bin:/usr/games:/usr/local/bin
export PATH
for DIR in $HOME/${ARCH}bin \
	$HOME/scripts \
	/bin \
	/opt/gnu/bin \
	/sbin \
	/usr/sbin \
	/etc/ \
	/usr/ucb \
	/usr/bin/X11 \
	/usr/X11/bin \
	/usr/openwin/bin \
	/opt/GCC2721/bin \
	/usr/ccs/bin \
	/usr/afsws/bin \
	/usr/etc \
	/usr/contrib/bin\
	/usr/contrib/mh/bin\
	/usr/games \
	/usr/local/bin/X11\
	/usr/freeware/bin\
	/usr/bsd \
	/sbin:/usr/sbin \
	/bin \
	/usr/bin \
    /usr/local/java/jdk1.7.0_45/bin \
	/opt/apache-maven-3.1.1/bin \
	/home/y/libexec/ant/bin \
	/usr/local/bin \
	/usr/local/mysql/bin \
	/usr/X11R6/bin \
	/home/jadestar/bak/homes/bin/ \
	/homes/mbeirne/scripts
do myaddpath ${DIR}
done
PATH=$PATH:.;export PATH
PATH=`echo $PATH |sed s/:\.:/:/`
PATH=`echo $PATH |sed s/::/:/`

### where to look for man pages (see also /etc/man.conf and man(1))
# myaddmanpath function
myaddmanpath()
{
	if [ -d ${1}  ]
	then
	    if `echo $MANPATH |egrep "${1}" >>/dev/null`
	    then
	    :
	    else
		MANPATH=${MANPATH}:${1}
	    fi
	fi
}
#MANPATH=/usr/man:/usr/share/man:/usr/contrib/man:/usr/contrib/mh/man:/usr/local/man:/usr/X11/man
for DIR in /usr/man \
	/usr/share/man \
	/usr/contrib/man \
	/usr/contrib/mh/man \
	/usr/openwin/man \
	/usr/freeware/man \
	/usr/local/man \
	/usr/X11/man \
	/usr/man \
	/usr/share/man \
	/usr/local/man \
	/usr/local/share/man \
	/usr/X11R6/man \
	/home/y/share/man/
do myaddmanpath ${DIR}
done
export MANPATH
#MOZILLA_HOME=/usr/local/netscape;export MOZILLA_HOME

#### default printer for lpr
PRINTER=psn
export PRINTER

### default editor for many applications
EDITOR=vi; export EDITOR

### a good alternative is: PAGER=less
PAGER=less; export PAGER
BLOCKSIZE=1k; export BLOCKSIZE

### uncomment to select an alternate timezone (/etc/localtime is default)
# TZ=/usr/share/zoneinfo/US/Central; export TZ
TZ='America/Los_Angeles'; export TZ

### NEWS Configuration
RNINIT="$HOME/.rninit"; export RNINIT
# ORGANIZATION='Widgets, Inc.'; export ORGANIZATION
# NNTPSERVER=news; export NNTPSERVER

### X Window System Configuration
XAPPLRESDIR="$HOME/.Xclasses/"; export XAPPLRESDIR
### Old-style XNLSPATH
# XNLSPATH=/usr/X11/lib/X11/nls; export XNLSPATH

### WWW Browser Configuration
# WWW_wais_GATEWAY="http://www.ncsa.uiuc.edu:8001"; export WWW_wais_GATEWAY
WWW_HOME="http://backyard3.yahoo.com/"; export WWW_HOME


### Usenet News server
#NNTPSERVER=news.wwa.com
#export NNTPSERVER

### Interactive only commands
case $- in *i*)
    #stty intr ^C erase ^H
    #stty crt -tostop erase '^H' kill '^U' intr '^C' status '^T'
    ### biff controls new mail notification
    #biff y
    #eval `tset -s -m 'network:?xterm'`
    ### mesg controls messages from other users
    #mesg y
    #if [ "X$TERM" = Xdialup -o "X$TERM" = Xunknown -o "X$TERM" = Xdumb ]; then
    #    TERM=`tset -Q -s -m ":?vt100"`
    #fi
esac
#export TERM
# Java variables
#CLASSPATH="/usr/http/admin/util:.:" ;export CLASSPATH
JAVA_HOME="/usr/local/java/jdk1.7.0_45";export JAVA_HOME

### Shell specific setup
case "$SHELL" in
    */bash) set -o emacs; set -o notify; set -o ignoreeof
	    command_oriented_history=1
    	    PS1='\h \A \w \$ ' 
	    ENV="$HOME/.shellrc"
	    export ENV PS1
	    [ -f "$ENV" ] && . "$ENV"
            ;;
    */ksh)  set -o emacs; set -o monitor; set -o ignoreeof
	    if [ -w /.profile ];then PSCH="#";USER="root";else PSCH="$";fi
	    PS1='! ${HOSTNAME}:${PWD}
$PSCH '
	    ENV="$HOME/.shellrc"
	    export PSCH ENV PS1
            ;;
    */zsh)  set -o emacs; set -o notify; set -o ignoreeof
            command_oriented_history=1
            setopt PROMPT_SUBST
            PROMPT='%(?.%F{green)ok.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
            ENV="$HOME/.shellrc"
            export ENV PS1
            [ -f "$ENV" ] && . "$ENV"
            ;;
    *)      set -I
	    PS1="${HOSTNAME}\$ "
	    ENV="$HOME/.shellrc"
	    export ENV PS1
		;;
esac

### email
MAIL="/var/mail/$USER"
MAILCHECK=30
MAILPATH="/var/mail/$USER"
export MAIL MAILCHECK MAILPATH

### shell history
HISTFILE="/var/tmp/${USER}.history"
HISTFILESIZE=5000
HISTSIZE=5000
FCEDIT="$EDITOR"
export HISTFILE HISTFILESIZE HISTSIZE FCEDIT

### umask sets a mask for the default file permissions,
### ``umask 002'' is less restrictive
umask 022

# put ssh-agent info in a file, so that it can be sourced in a new tmux window
if ssh-add -l >>/dev/null 2>&1
then
env |grep SSH_AUTH |sed -e 's/^/export /' >ssh-agent
else source ~/ssh-agent
fi

if [ -f $HOME/.profile.locale ]; then
    . $HOME/.profile.locale
fi
#lognew
