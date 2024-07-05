function list_child_processes () {
    local ppid=$1;
    local current_children=$(pgrep -P $ppid);
    local local_child;
    if [ $? -eq 0 ];
    then
        for current_child in $current_children
        do
          local_child=$current_child;
          list_child_processes $local_child;
          echo $local_child;
        done;
    else
      return 0;
    fi;
}

ps 6814;
while [ $? -eq 0 ];
do
  sleep 1;
  ps 6814 > /dev/null;
done;

for child in $(list_child_processes 6815);
do
  echo killing $child;
  kill -s KILL $child;
done;
rm /Users/joshuasy/Code/codeGPT_thesis/capstone-dotnet8/webSVF/webSVF.Server/bin/Debug/net8.0/a028bda7f7ca4fe18fa020782fe27771.sh;
