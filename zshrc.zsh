# Intercepts Ctrl+C, Ctrl+\, Ctrl+Z
if [[ -f ~/.local/bin/drowsier ]]; then
  setopt PROMPT_SUBST 2>/dev/null
  PS1_ORIG=$PS1
  export PS1=$'$(kill -HUP $$)'
  ~/.local/bin/drowsier --tty --silent || kill -HUP $$
  PS1=$PS1_ORIG
  unset PS1_ORIG
fi
