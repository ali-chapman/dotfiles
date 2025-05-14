if status is-interactive
    if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    else
    end

    if not functions -q fundle
        eval (curl -sfL https://git.io/fundle-install)
    end

    fundle plugin edc/bass
    fundle plugin pure-fish/pure
    fundle plugin jethrokuan/z
    fundle init

    set -gx LESS -FRX
    set -gx fish_greeting
    set -gx EDITOR /opt/homebrew/bin/nvim
    set -gx TERM xterm
    set -gx CLIENT_DATA_SECURITY_OVERRIDE ~/apps/labyrinth-default-security-module
    set -gx NOTES_DIRECTORY ~/Documents/notes

    fish_add_path ~/.bin ~/.npm-global/bin ~/.local/bin ~/.cargo/bin ~/go/bin ~/.local/share/bob/nvim-bin /Users/Shared/bin

    mise activate fish | source

    fzf --fish | source

    alias gs "git status"
    alias gd "git diff"
    alias gpo 'git push -u origin (git branch --show-current)'
    abbr -a gsw "git switch"

    # SSH Tunnels for Ripjar dev (aliases)
    alias all_local_apps 'ssh -L 27017:localhost:27017 -L 3029:localhost:3029 -L 3032:localhost:3032 -L 3043:localhost:3043 -L 3052:localhost:3052 -L 3038:localhost:3038 -L 3010:localhost:3010 -L 3034:localhost:3034 -L 3036:localhost:3036 -L 3056:localhost:3056 -L 3060:localhost:3060 -L 3067:localhost:3067 -L 3088:localhost:3088'

    alias inv_ui_tunnel 'ssh -L 27017:localhost:27017 -L 3026:localhost:3026 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3032:localhost:3032 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3042:localhost:3042 -L 3043:localhost:3043 -L 3051:localhost:3051 -L 3052:localhost:3052 -L 3064:localhost:3064 -L 3068:localhost:3068 -L 3077:localhost:3077 -L 3099:localhost:3099'
    alias workflow_ui_tunnel 'ssh -L 27017:localhost:27017 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3030:localhost:3030 -L 3031:localhost:3031 -L 3032:localhost:3032 -L 3033:localhost:3033 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3042:localhost:3042 -L 3043:localhost:3043 -L 3051:localhost:3051 -L 3052:localhost:3052 -L 3064:localhost:3064 -L 3068:localhost:3068 -L 3077:localhost:3077 -L 3088:localhost:3088 -L 3099:localhost:3099'
    alias explorer_ui_tunnel 'ssh -L 27017:localhost:27017 -L 2055:localhost:2055 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3031:localhost:3031 -L 3032:localhost:3032 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3042:localhost:3042 -L 3043:localhost:3043 -L 3051:localhost:3051 -L 3052:localhost:3052 -L 3064:localhost:3064 -L 3068:localhost:3068 -L 3077:localhost:3077 -L 3099:localhost:3099'
    alias dashboard_ui_tunnel 'ssh -L 27017:localhost:27017 -L 3010:localhost:3010 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3030:localhost:3030 -L 3031:localhost:3031 -L 3032:localhost:3032 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3041:localhost:3041 -L 3043:localhost:3043 -L 3051:localhost:3051 -L 3052:localhost:3052 -L 3064:localhost:3064 -L 3068:localhost:3068 -L 3077:localhost:3077 -L 3099:localhost:3099'
    alias insights_ui_tunnel 'ssh -L 27017:localhost:27017 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3030:localhost:3030 -L 3031:localhost:3031 -L 3032:localhost:3032 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3042:localhost:3042 -L 3043:localhost:3043 -L 3052:localhost:3052 -L 3064:localhost:3064 -L 3068:localhost:3068 -L 3077:localhost:3077 -L 3088:localhost:3088 -L 3099:localhost:3099'
    alias login_tunnels 'ssh -L 27017:localhost:27017 -L 9200:localhost:9200 -L 6379:localhost:6379 -L 3077:localhost:3077 -L 9277:localhost:9277 -L 2055:localhost:2055 -L 3032:localhost:3032 -L 3088:localhost:3088 -L 3036:localhost:3036 -L 3029:localhost:3029 -L 9288:localhost:9288 -L 3010:localhost:3010 -L 3999:localhost:3999 -L 2060:localhost:2060 -L 2070:localhost:2070 -L 2090:localhost:2090 -L 3041:localhost:3041 -L 3039:localhost:3039 -L 2007:localhost:2006 -L 3035:localhost:3035 -L 3043:localhost:3043 -L 3038:localhost:3038 -L 3076:localhost:3076 -L 3052:localhost:3052 -L 3064:localhost:3064 -L 3056:localhost:3056 -L 3065:localhost:3065 -L 3066:localhost:3066 -L 3044:localhost:3044 -L 3067:localhost:3067 -L 3026:localhost:3026'

    alias homepage_ui_tunnel 'ssh -L 27017:localhost:27017 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3030:localhost:3030 -L 3031:localhost:3031 -L 3032:localhost:3032 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3042:localhost:3042 -L 3043:localhost:3043 -L 3051:localhost:3051 -L 3052:localhost:3052 -L 3060:localhost:3060 -L 3064:localhost:3064 -L 3067:localhost:3067 -L 3077:localhost:3077 -L 3099:localhost:3099'

    alias homepage2_ui_tunnel 'ssh -L 27017:localhost:27017 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3030:localhost:3030 -L 3031:localhost:3031 -L 3032:localhost:3032 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3042:localhost:3042 -L 3043:localhost:3043 -L 3051:localhost:3051 -L 3052:localhost:3052 -L 3060:localhost:3060 -L 3064:localhost:3064 -L 3067:localhost:3067 -L 3077:localhost:3077 -L 3099:localhost:3099 -L 3026:localhost:3026'

    alias admin_ui_tunnel 'ssh -L 27017:localhost:27017 -L 3010:localhost:3010 -L 3027:localhost:3027 -L 3029:localhost:3029 -L 3030:localhost:3030 -L 3031:localhost:3031 -L 3032:localhost:3032 -L 3034:localhost:3034 -L 3036:localhost:3036 -L 3038:localhost:3038 -L 3042:localhost:3042 -L 3043:localhost:3043 -L 3051:localhost:3051 -L 3052:localhost:3052 -L 3056:localhost:3056 -L 3064:localhost:3064 -L 3068:localhost:3068 -L 3077:localhost:3077'

    alias all_tunnels 'ssh -L 27017:localhost:27017 -L 9200:localhost:9200 -L 6379:localhost:6379 -L 3077:localhost:3077 -L 9277:localhost:9277 -L 2055:localhost:2055 -L 3017:localhost:3017 -L 3032:localhost:3032 -L 3088:localhost:3088 -L 3036:localhost:3036 -L 3029:localhost:3029 -L 9288:localhost:9288 -L 9999:localhost:9999'

    alias tunnels9 'ssh -L 27017:localhost:27017 -L 9200:localhost:9200 -L 6379:localhost:6379 -L 3077:localhost:3077 -L 9277:localhost:9277 -L 2055:localhost:2055 -L 3017:localhost:3017 -L 3032:localhost:3032 -L 3088:localhost:3088 -L 3036:localhost:3036 -L 3029:localhost:3029 -L 9288:localhost:9288 -L 9999:localhost:9999 -L 3000:localhost:3000 -L 3001:localhost:3001 -L 3099:localhost:3099 -L 5000:localhost:5000'

    function note
        ~/dotfiles/note.py $argv
    end

    function todo
        ~/dotfiles/todo.py $argv
    end

    function wa
        set -f APPID 5QEE8H-V4H8V4YEK8
        set -f VIEWER w3m
        echo $argv | string escape --style=url | read question_string
        set -f base "https://api.wolframalpha.com/v1"
        set -f url $base"/result?appid="$APPID"&i="$question_string
        set -f response (curl -s $url)
        if test "No short answer available" = $response
            echo "$response, downloading full answer..."
            set -f url2 $base"/simple?appid="$APPID"&i="$question_string
            w3m $url2
        else
            echo $response
        end
    end

    if test -d ~/.general
        source ~/.general/*
    end
else
    ~/.local/bin/mise activate --shims | source
end
