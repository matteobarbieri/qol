#!/bin/bash

ALIASES_FILE=~/.aliases

# Update just in case
# sudo apt update

# Location of the script. NOTE: does not have trailing '/'
# It should probably look something like /home/user/repo/qol/setup_scripts
export SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

print_help()
{
  echo "Quality of Life script"
  echo "Install common use programs and packages and custom configurations"
  echo "Usage:"
  echo "./setup_ubuntu.sh"
}

# Print a recap of all components that are about to be installed/configured
recap_choices()
{
  COMPONENTS=$@
  echo "The following components will be installed:"
  echo $COMPONENTS

  echo -n "Proceed with the installation? [y/N] "
  read CHOICE

  if [ "$CHOICE" == 'y' ] || [ "$CHOICE" == 'Y' ]; then
    return 1
  else
    echo "Installation cancelled"
    exit 1
  fi
}

show_whiptail_menu()
{

  # Show menu
  COMPONENTS=$(
    NEWT_COLORS='
    root=,black
    checkbox=white,black
    actcheckbox=white,magenta
    border=white,black
    window=,black
    button=white,magenta' \
        whiptail --checklist "Choose which component to install (SPACE to toggle)" 16 95 7 \
    "core" "Core programs (htop, tmux et similia)" on \
    "zsh" "Zsh shell and antigen (plus a fancy theme for oh-my-zsh)" on \
    "anaconda" "Anaconda (Python framework plus default virtual envs)" on \
    "vim" "Vim text editor (plus several Vundle plugins and custom .vimrc)" on \
    "awesomewm" "Awesome window manager (plus themes and plugins)" off \
    "desktop" "Desktop programs (Docky, Google Chrome and more)" off \
    "xfce4-terminal" "The xfce4-terminal (and cool color schemes)" on \
    3>&1 1>&2 2>&3) # needed to redirect output to variable

  # Remove airquotes
  COMPONENTS=$(sed -e 's/"//g' <<< "$COMPONENTS")

  echo $COMPONENTS
}

main()
{

  POSITIONAL=()
  while [[ $# -gt 0 ]]
  do
  key="$1"

  case $key in
      # -e|--extension)
      # EXTENSION="$2"
      # shift # past argument
      # shift # past value
      # ;;
      -h|--help)
      HELP=true
      shift # past argument
      ;;
      *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
  done
  set -- "${POSITIONAL[@]}" # restore positional parameters

  # Display help and exit
  if [ $HELP ]; then
    print_help
    exit 0
  fi

  # Check for the existence of whiptail
  which whiptail 2> /dev/null > /dev/null
  WHIPTAIL_DOESNT_EXIST=$?
  [ $WHIPTAIL_DOESNT_EXIST = 0 ] && COMPONENTS=$(show_whiptail_menu)

  # Without whiptail, take the list of components from the rest of arguments
  # passed.
  [ $WHIPTAIL_DOESNT_EXIST = 0 ] || COMPONENTS=$@

  COMPONENTS_PATH="${SCRIPTPATH}/setup-scripts/components"

  if [ -z "$COMPONENTS" ]; then
    echo "No components selected, leaving installation."
    exit 0
  fi

  for C in $COMPONENTS; do
      if [ -f "${COMPONENTS_PATH}/setup_${C}.sh" ]
      then
          :
      else
         echo "Component $C not found, exiting";
         exit 0;
      fi
      
  done

  # Recap the components that are about to be installed
  recap_choices $COMPONENTS

  for C in $COMPONENTS; do
    # For each component, source the corresponding file and
    # launch the installation command
    source "${COMPONENTS_PATH}/setup_${C}.sh"
    setup_$C $ALIASES_FILE
  done
}

main $@
