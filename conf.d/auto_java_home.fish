function __auto_set_java_home --on-variable PWD --description "Automatically set JAVA_HOME"
  status --is-command-substitution; and return

  # Check if we are inside a git repository
  if git rev-parse --show-toplevel &>/dev/null
    set dir (realpath (git rev-parse --show-toplevel))
  else
    set dir (pwd)
  end

  # Find a .java_home file
  if test -e "$dir/.java_home"
    # back up the java home unless it's been backed up already
    set -q $OLD_JAVA_HOME; or set -g OLD_JAVA_HOME $JAVA_HOME
    read -gx JAVA_HOME < "$dir/.java_home"
  else
    # we're leaving a directory controlled by .java_home,
    # load the old JAVA_HOME and delete the backup
    set -gx JAVA_HOME $OLD_JAVA_HOME
    set -g -e OLD_JAVA_HOME
  end

end


__auto_set_java_home
