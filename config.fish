### FUNCTIONS

function __source
  if test -f $argv
    source $argv
  else if test -L $argv && test -e $argv && test -f (readlink -f $argv)
    source $argv
  end
end

__source ~/.nix-profile/etc/profile.d/nix.fish


### ENV
set -gx PATH $HOME/.local/bin $PATH
set -gx EDITOR vi

# disable fishs greeter
set -gx fish_greeting ''

# disable emojis when using pipx
set -gx USE_EMOJI false

# prevent less from cluttering my $HOME
set -gx LESSHISTSIZE 0
set -gx LESSHISTFILE '/dev/null'


# WSL specific settings
#if test -n $WSL_DISTRO_NAME
#
#end

# only for interactive sessions
if status is-interactive

    # aliases
    alias mv 'mv -i'
    alias cp 'cp -ir'
    alias rm 'rm -ir'
    alias mkdir 'mkdir -p'
    alias ll 'ls -l'
    alias la 'ls -la'
    alias grep 'grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
    alias ... 'cd ../..'
    alias .... 'cd ../../..'
    alias wget 'wget --hsts-file /dev/null'
    alias m 'make'
    alias g 'git'

    if command -v tmux >/dev/null
      alias t 'tmux'
    end

    if command -v nvim >/dev/null
        set -gx EDITOR nvim
        alias n nvim
        alias vi nvim
        alias vim nvim
    end

    # replace ls with exa
    if command -v exa >/dev/null
        alias ls 'exa'
        alias ll 'exa -l'
        alias la 'exa -la'
    end

    if command -v xdg-open >/dev/null
        alias o 'xdg-open'
        alias open 'xdg-open'
    end

end

# unset functions
functions -e __source
