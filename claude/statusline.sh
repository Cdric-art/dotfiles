#!/bin/sh
# Status line Claude Code : starship (profil claude-code) + niveau d'effort.
# starship 1.26 n'expose pas l'effort : on l'extrait du JSON reçu sur stdin
# et on le passe à starship via la variable CLAUDE_EFFORT (module env_var).
input=$(cat)
CLAUDE_EFFORT=$(printf '%s' "$input" | jq -r '.effort.level // .effort // empty' 2>/dev/null)
export CLAUDE_EFFORT
printf '%s' "$input" | starship statusline claude-code
