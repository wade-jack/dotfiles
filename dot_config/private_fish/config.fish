if test (uname) = Darwin
    if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    else if test -x /usr/local/bin/brew
        eval (/usr/local/bin/brew shellenv)
    end
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else if test -x /home/linuxbrew/.homebrew/bin/brew
    eval (/home/linuxbrew/.homebrew/bin/brew shellenv)
end

for completion_dir in \
   /opt/homebrew/share/fish/vendor_completions.d \
   /usr/local/share/fish/vendor_completions.d \
   /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d \
   /home/linuxbrew/.homebrew/share/fish/vendor_completions.d
   if test -d "$completion_dir"
       if not contains -- "$completion_dir" $fish_complete_path
           set -g fish_complete_path "$completion_dir" $fish_complete_path
       end
   end
end

if status is-interactive
   if command -q fnm
       fnm env --use-on-cd --shell fish | source
   end
    if command -q fzf
        fzf --fish | source
    end
    if command -q zoxide
        zoxide init fish | source
    end
end

function y --wraps yazi --description "Yazi wrapper that cds into the last visited directory"
    set -l tmp (mktemp)
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
