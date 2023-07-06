if status is-interactive
  set -gx LESS "-FRX"
  set -gx PNPM_HOME "/home/alichapman/.local/share/pnpm"
  set -gx fish_greeting

  fish_add_path ~/.npm-global/bin ~/.local/bin ~/.cargo/bin ~/go/bin $PNPM_HOME

  alias gs "git status"
  alias gd "git diff"
  alias gpo 'git push -u origin $(git branch --show-current)'
end
