_update_pip_index() {
  INDEX_AGE=$(stat -c %Y ~/.pip_index 2>/dev/null || echo 0)
  NOW=$(date +%s)
  DIFF_S=$(expr $NOW - $INDEX_AGE)
  DIFF_H=$(expr $DIFF_S / 3600)
  if [ $DIFF_H -gt 24 ]; then
    curl --silent https://pypi.org/simple/ | grep href | sed 's/>/</g' | awk -F'<' '{print $3}' >~/.pip_index
  fi
}

_pip_completion() {
  # complete subcommands
  if [[ $COMP_CWORD == 1 ]]; then
    curr_word="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY1=($(compgen -W "info pypi require old" -- ${curr_word}))
    COMPREPLY2=($(COMP_WORDS="${COMP_WORDS[*]}" \
      COMP_CWORD=$COMP_CWORD \
      PIP_AUTO_COMPLETE=1 $1))
    # combine
    COMPREPLY=($(echo ${COMPREPLY1[*]}) $(echo ${COMPREPLY2[*]}))
    return 0
  fi

  # complete packages
  if [[ $COMP_CWORD == 2 && "download info install pypi require search" =~ ${COMP_WORDS[1]} ]]; then
    _update_pip_index
    curr_word="${COMP_WORDS[COMP_CWORD]}"
    packages=$(grep $curr_word ~/.pip_index)
    COMPREPLY=($(compgen -W "${packages}" -- ${curr_word}))
    return 0
  fi

  COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
    COMP_CWORD=$COMP_CWORD \
    PIP_AUTO_COMPLETE=1 $1))
}

pip-info() {
  curl --silent -L https://pypi.org/project/$1 |
    xmllint --xpath '//div[@id="description"]' --html - 2>/dev/null |
    html2text | pygmentize -l md
}

pip-require() {
  full_name="$1"
  # strip version details: eg foo==0.1 becomes just foo
  package=$(echo $full_name | sed 's/\(^[-_a-zA-Z0-9]\+\).*/\1/')
  pip install "$full_name" &&
    pip freeze | grep -i "\b$package\b" >>${2:-requirements.txt}
}

pip-pypi() {
  xdg-open "https://pypi.org/project/$1/"
}

pip() {
  case $1 in
  info)
    pip-info ${@:2}
    ;;
  require)
    pip-require ${@:2}
    ;;
  pypi)
    pip-pypi $2
    ;;
  old)
    pip-old ${@:2}
    ;;
  isntall) # common typo
    pip install ${@:2}
    ;;
  *)
    command pip $@
    ;;
  esac
}

complete -o default -F _pip_completion pip
