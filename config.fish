if status is-interactive
  set -gx LESS "-FRX"
  set -gx PNPM_HOME "/home/alichapman/.local/share/pnpm"
  set -gx fish_greeting
  set -gx EDITOR "~/.local/bin/lvim"

  fish_add_path ~/.npm-global/bin ~/.local/bin ~/.cargo/bin ~/go/bin $PNPM_HOME

  alias gs "git status"
  alias gd "git diff"
  alias gpo 'git push -u origin $(git branch --show-current)'
  abbr -a gsw "git switch"

  function wa
    set -f APPID "5QEE8H-V4H8V4YEK8"
    set -f VIEWER "w3m"
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
end
