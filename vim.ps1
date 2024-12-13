$wpath=$args[0] -replace "\\","/"
$lpath=wsl wslpath -a "$wpath"
wt wsl -e vim $lpath
