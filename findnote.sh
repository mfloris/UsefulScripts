# Search notes in a predefined folder using terminal interface for spotlight

alias findnote='mdfind -onlyin /Users/mfloris/Documents/MyNotes'
#echo $results
set -f              
IFS='
'

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

nlines_grep=5
open_id="NO"
do_grep="NO"
searchquery=""
copy_id="NO"

give_help() {

    echo "$0 options <search pattern> "
    echo "Available Options: "
    echo " -h                   This help"
    echo " -o <id>              Open matching <id>"
    echo " -c <id>              Copy matching <id> to clipboard"
    echo " -g                   Grep mathcin files for search pattern (only greps .md files)"
    echo " -A <nlines>          If grepping, shown nlines (DEF: $nlines_grep) around match"
    echo " -s <search pattern>  You can put search patter as a positional argument, but using"
    echo "                      this option is useful if you want to put any of the other options "
    echo "                      after the search string"

}


while getopts "ho:gA:s:c:" opt; do
  case $opt in
      h)
          give_help
          ;;
      o)
          open_id=$OPTARG
          ;;
      g)
          do_grep="YES"
          ;;
      A)
          nlines_grep=$OPTARG
          ;;
      s)
          searchquery=$OPTARG
          ;;
      c)
          copy_id=$OPTARG
          ;;
     

  esac

done
shift $(expr $OPTIND - 1) # get rid of parsed args

if [ "$searchquery" = "" ]
then
    searchquery=$@
    if [ "$searchquery" = "" ]
    then
        echo "Must give a search query"
        exit
    fi
fi



results=`mdfind -onlyin /Users/mfloris/Documents/MyNotes $searchquery`

counter=0
for i in $results
do
    if [[ "$i" != *~ ]]
    then

        echo -e "${GREEN}$counter) ${RED} $i ${NC}"

        extension="${i##*.}"
        grep_string=$@
        grep_string=${grep_string// /\\|}
        if [ "$do_grep" = "YES" ] && [ "$extension" = "md" ] 
        then
            echo "----- GREP -----"
            grep --color "$i" -A $nlines_grep -i -e $grep_string # use terms from search in or for the grep
            echo "---------------"
        fi

        if [ "$open_id" != "NO" ] && [ "$open_id" = "$counter" ]
        then
           open "$i"
        fi

        if [ "$copy_id" != "NO" ] && [ "$copy_id" = "$counter" ]
        then
           echo -n "${i}" | pbcopy
        fi

        counter=$((counter+1))

        
#        grep  -ie "$@" $i 
    fi
done


unset IFS
set +f
