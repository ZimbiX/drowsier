# Intercepts Ctrl+C, Ctrl+\, Ctrl+Z
if command -v drowsier &>/dev/null; then
  setopt PROMPT_SUBST 2>/dev/null
  PS1_ORIG=$PS1
  export PS1=$'$(kill -HUP $$)'
  drowsier --tty || kill -HUP $$
  PS1=$PS1_ORIG
  unset PS1_ORIG
fi
