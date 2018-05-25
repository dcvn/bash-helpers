# ~bash~
# Colours in tput format
has_term () { [ "" != "$TERM" ] ; }

# Foreground colours
black ()   { has_term && tput setaf 0 2>/dev/null ; }
red ()     { has_term && tput setaf 1 2>/dev/null ; }
green ()   { has_term && tput setaf 2 2>/dev/null ; }
yellow ()  { has_term && tput setaf 3 2>/dev/null ; }
blue ()    { has_term && tput setaf 4 2>/dev/null ; }
magenta () { has_term && tput setaf 5 2>/dev/null ; }
cyan ()    { has_term && tput setaf 6 2>/dev/null ; }
white ()   { has_term && tput setaf 7 2>/dev/null ; }

bold ()    { has_term && tput bold 2>/dev/null ; }
unbold ()  { has_term && tput sgr0 2>/dev/null ; }

# Background colours

bblack ()   { has_term && tput setab 0 2>/dev/null ; }
bred ()     { has_term && tput setab 1 2>/dev/null ; }
bgreen ()   { has_term && tput setab 2 2>/dev/null ; }
byellow ()  { has_term && tput setab 3 2>/dev/null ; }
bblue ()    { has_term && tput setab 4 2>/dev/null ; }
bmagenta () { has_term && tput setab 5 2>/dev/null ; }
bcyan ()    { has_term && tput setab 6 2>/dev/null ; }
bwhite ()   { has_term && tput setab 7 2>/dev/null ; }

uncolor ()   { white; unbold; bblack; }

