# Aliases #########
alias git 'hub'
alias g 'git'
alias fish-config 'vim ~/.config/fish/config.fish'
alias fish-reload '. ~/.config/fish/config.fish'
alias t 'python ~/bin/t/t.py --task-dir ~/bin/t/tasks --list tasks'
alias tmux 'tmux -2'

# Path ############
function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in it"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -gx PATH "$argv[1]" $PATH
        end
    end
end
set PATH /usr/local/bin /usr/sbin /usr/bin /sbin /bin
set PATH ~/bin $PATH
set PATH ~/.rbenv/bin/ $PATH
set PATH ~/.rbenv/shims/ $PATH
set PATH /usr/local/share/python $PATH

# Prompt

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set gray (set_color -o black)
set hg_promptstring "< on $magenta<branch>$normal>< at $yellow<tags|$normal, $yellow>$normal>$green<status|modified|unknown><update>$normal<
patches: <patches|join( → )|pre_applied($yellow)|post_applied($normal)|pre_unapplied($gray)|post_unapplied($normal)>>" 2>/dev/null

function virtualenv_prompt
    if [ -n "$VIRTUAL_ENV" ]
        printf '(%s) ' (basename "$VIRTUAL_ENV")
    end
end

function hg_prompt
    hg prompt --angle-brackets $hg_promptstring 2>/dev/null
end

function git_prompt
    if git root >/dev/null 2>&1
        set_color normal
        printf ' on '
        set_color magenta
        printf '%s' (git currentbranch ^/dev/null)
        set_color green
        git_prompt_status
        set_color normal
    end
end


function fish_prompt
    set last_status $status

#z --add "$PWD"

    echo

    set_color magenta
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color yellow
    printf '%s' (hostname|cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

#hg_prompt
    git_prompt

    echo

    virtualenv_prompt

    if test $last_status -eq 0
        set_color white -o
        printf '><((°> '
    else
        set_color red -o
        printf '[%d] ><((ˣ> ' $last_status
    end

    set_color normal
end

function alt_prompt
    printf "%s%s%s at " (set_color magenta) (whoami) (set_color normal)
    printf "%s%s%s in " (set_color yellow) (hostname|cut -d . -f 1) (set_color normal)
    printf "%s%s%s" (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

function gpt
    set before_gems (md5 Gemfile)
    set before_migrations (ls -l ./db/migrate | wc -l)
    git pull tapjoy master
    set after_gems (md5 Gemfile)
    set after_migrations (ls -l ./db/migrate | wc -l)

    if [ $before_gems != $after_gems ]
        echo 'Updated gems avalible'
    end
    if [ $before_migrations != $after_migrations ]
        echo 'New migrations avalible'
    end
end
