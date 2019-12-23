# pgrep查找与谷歌浏览器有关的进程号
# -o 筛选出这些进程号中最小的一个，这个最小的就是其他的父进程
# 使用变量 v 保存结果

onExit(){
  echo ""
  read -p "input enter to exit..."
  exit;
}

onKill(){
  # 杀掉 谷歌浏览器进程
  #kill $ppid;
  echo ""
  kill $1 
  sleep 1
  openChrome
  onExit
}

onKillConfirm(){
  echo ""
  read -p "there have Google Chrome process, kill it continue?[Y/N]" argv
  case $argv in
    [yY][eE][sS]|[yY])
      onKill $1
      break;;
    [nN][oO]|[nN])
      onExit
      break;;
    *)  #Autocontinue
      onKillConfirm $1
      break;;
  esac
}

openChrome(){
  open -a Google\ Chrome http://localhost:3000 --args --disable-web-security --user-data-dir --disable-features=CrossSiteDocumentBlockingIfIsolating
}

start(){
  ppid=$(pgrep -o "Google Chrome");
  echo "ppid: ${ppid}"
  if [ ! $ppid ]; then
    echo ""
    echo "no Google Chrome process, still open with http://localhost:3000"
    openChrome
    onExit 
  else
    onKillConfirm $ppid
  fi 
}

start;

# 杀掉 谷歌浏览器进程
#kill $ppid;


