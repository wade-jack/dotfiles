/opt/homebrew/bin/brew shellenv | source
set -gx MICRO_TRUECOLOR 1

fnm env --use-on-cd --shell fish | source

if status is-interactive
    starship init fish | source
    fzf --fish | source
    zoxide init fish | source
    env TF_SHELL=fish thefuck --alias | source
end

function y --wraps yazi --description "Yazi wrapper that cds into the last visited directory"
    set -l tmp (mktemp -t yazi-cwd.XXXXXX)
    command yazi $argv --cwd-file="$tmp"

    if test -f "$tmp"
        set -l cwd (cat "$tmp")
        if test -n "$cwd" -a "$cwd" != "$PWD" -a -d "$cwd"
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end

abbr -a lg lazygit
abbr -a g git
abbr -a ga "git add"
abbr -a gc "git commit --verbose"
abbr -a gco "git checkout"
abbr -a gst "git status"

# opencode
fish_add_path $HOME/.opencode/bin
