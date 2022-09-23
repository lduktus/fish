#!/usr/bin/env fish

# duktus 2022

function __install_fisher
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; and return 0
  return 1
end

function __install_plugins
  fisher install mattgreen/lucid.fish; and fisher install jethrokuan/z; and return 0
  return 1
end

__install_fisher; and __install_plugins
