if [ $OSTYPE = 'Linux' ]
then
  alias ls='ls -A --color=auto'
elif [ $OSTYPE = 'Darwin' -o $OSTYPE = 'Unix' ]
then
  alias ls='ls -AG'
elif [ $OSTYPE = 'WINDOWS' ]
then
fi

