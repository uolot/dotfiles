" typos
iabbrev affilaite affiliate
iabbrev aroung around
iabbrev datetiem datetime
iabbrev improt import
iabbrev istnall install
iabbrev Lust Lyst
iabbrev lust lyst
iabbrev tiem time
iabbrev tje the
iabbrev uplaod upload

" bash shebang
set iskeyword+=!
iabbrev !bash #!/usr/bin/env bash

" insert current date
iabbrev <expr> YMD strftime("%Y-%m-%d")
iabbrev <expr> YMDD strftime("%Y-%m-%d %a")
iabbrev <expr> HM strftime("%H:%M")
iabbrev <expr> HMS strftime("%H:%M:%S")
command DATE :%s/DATE/\=strftime("%Y-%m-%d")/gc
command TODAY :%s/TODAY/\=strftime("%Y-%m-%d")/gc
command DAYOFWEEK :%s/DAYOFWEEK/\=strftime("%a")/gc
