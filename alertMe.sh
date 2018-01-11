if [ "$1" = "" ]
then
    echo "Usage: $0 <command>"
    echo "Executes command and opens a pop up window when done"
fi

command=$@
$command

osascript -e "tell app \"System Events\" to display dialog \"Command $1 done!\""
#if the user clicks ok, return to terminal
if [ "$?" = "0" ]
    then
    open -a Terminal
fi

