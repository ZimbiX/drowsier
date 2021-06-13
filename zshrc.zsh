# Intercepts Ctrl+C, Ctrl+\, Ctrl+Z
if command -v drowsier &>/dev/null; then
  setopt PROMPT_SUBST 2>/dev/null
  PROMPT_ORIG=$PROMPT
  PROMPT=$'$(kill -HUP $$)'
  drowsier --tty || kill -HUP $$
  PROMPT=$PROMPT_ORIG
  unset PROMPT_ORIG
fi
