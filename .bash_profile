alias l="ls -la"
alias gra="grails run-app"
# git alias
alias gst="git status"
alias gc="git commit"
alias ga="git add"
alias gcma="git commit -a -m"
alias gl="git pull"
alias gp="git push"
alias glo="git pull origin"
alias gpo="git push origin"
alias gb="git branch"
alias gco="git checkout"
alias gd="git diff"

alias b="vim ~/.bash_profile"
alias reso="source ~/.bash_profile"
alias vimrc="vim ~/.vimrc"
alias buildetw7='mvn -Pdevelopment -Detw.properties.directory="/Users/james.kieley/etw-web/src/main/resources/META-INF/properties" -DuseLess=true tomcat7:run'
alias buildetw7c='mvn -Pdevelopment -Detw.properties.directory="/Users/james.kieley/etw-web/src/main/resources/META-INF/properties" -DuseLess=true clean tomcat7:run'
alias sshconfig='vim ~/.ssh/config'
alias snippet='cd /Users/james.kieley/Library/Application\ Support/Sublime\ Text\ 3/Packages/User'

SQL_DUMP_LOCATION='/Users/james.kieley/etw-db/fromryan/cloud-internal.sql.gz'
ETW_PROPERTIES_FILE=/Users/james.kieley/etw-web/src/main/resources/META-INF/properties/etw.properties


alias pomv='sed -n 7p pom.xml | sed -e "s/<[^>]*>//g" | sed -e "s/-S.*//g" | trim | pbcopy'
# This function has been written to pipe something to it, currently does work with straight invocation :/ 
trim(){
    while read data; do # enable the ability to pipe to this function
        echo -n $data | tr -d "\r" | tr -d "\n" | tr -d " "
    done
}
uuid(){
    groovy -e "import static java.util.UUID.randomUUID; print randomUUID();" | pbcopy
}

reloaddb(){
    echo "***** Loading sql dump *****"
    echo "Sql dump location: $SQL_DUMP_LOCATION"
    echo "loading..."
    gunzip < $SQL_DUMP_LOCATION | mysql -uroot $1
    echo "done!"
}
drop_create_db(){
    echo "**** Dropping and Createing DB ****"
    echo "Db name: $1"
    echo "executing...."
    mysql -uroot -e "drop database $1;create database $1;"
    echo "done!"
}
drop_reload(){
    drop_create_db $1
    reloaddb $1
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
gpwd() {
	echo -n `pwd` | pbcopy	
}

export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home' # Java 1.7
# export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home' # Java 1.8

export CATALINA_HOME='/usr/local/Cellar/tomcat/8.0.15/libexec'
export PS1="\W\[\033[32m\] (\$(parse_git_branch))\[\033[00m\] $ "
export MAVEN_OPTS="-Xms256m -Xmx2048m -XX:MaxPermSize=384m"

service(){
    if [ "$1" = "tomcat" ]; then
        if [[ "$2" = "start" ]]; then
            /usr/local/Cellar/tomcat/8.0.15/libexec/bin/startup.sh
        fi
        if [[ "$2" = "stop" ]]; then
            /usr/local/Cellar/tomcat/8.0.15/libexec/bin/shutdown.sh
        fi
    fi
}

etw(){
    if [ "$1" = "" ]; then
        cd ~/etw-web
    fi
    if [ "$1" = "db" ]; then
        if [ "$2" = "which" ]; then
            etw_which_db
        fi
        if [ "$2" = "switch" ]; then
            etw_switch_db $3
        fi
        if [ "$2" = "pass" ]; then
            mysql -uroot -e "UPDATE $3.user_account SET PASSWORD = '\$2a\$10\$1QYpTwAUtwWYV5lRBvFPae9lyd8NhLlafLflpcmEZHfBSJQzkBWqa';"
        fi
        if [ "$2" = "reload" ]; then
            reloaddb $3
        fi
    fi
}

etw_switch_db(){
    local REPLACE_SCRIPT=/Users/james.kieley/git/my-groovy-scripts/replace.groovy 
    
    echo "***** Switching Properties File DB ******"
    echo -n "Changeing Properties file:" 
    echo "$ETW_PROPERTIES_FILE"
    echo "Prevous Db:"
    sed -n 11p $ETW_PROPERTIES_FILE
    
    $REPLACE_SCRIPT $ETW_PROPERTIES_FILE $1
    etw_which_db
}

etw_which_db(){
    echo "Current Db:"
    sed -n 11p $ETW_PROPERTIES_FILE
}

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/james.kieley/.gvm/bin/gvm-init.sh" ]] && source "/Users/james.kieley/.gvm/bin/gvm-init.sh"

export NVM_DIR="/Users/james.kieley/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

