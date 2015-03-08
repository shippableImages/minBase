append () {
  # First remove the directory
  local IFS=':'
  local NEWPATH
  for DIR in $PATH; do
     if [ "$DIR" != "$1" ]; then
       NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
     fi
  done

  # Then append the directory
  export PATH=$NEWPATH:$1
}

if [ -f "$HOME/.bashrc" ] ; then
  source $HOME/.bashrc
fi

if [ -d "$HOME/bin" ] ; then
  append $HOME/bin
fi

unset append
