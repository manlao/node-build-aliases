#!/usr/bin/env bash

resolve_versions() {
  if [ -L "$(nodenv-aliases --aliases_path)/$DEFINITION" ]; then
    VERSION_NAME=$(nodenv-aliases --resolve_definition "$DEFINITION")
    export VERSION_NAME
    export PREFIX="$NODENV_ROOT/versions/$VERSION_NAME"
  fi
}

unalias_versions() {
  if [ "$STATUS" -eq 0 ] && [ -n "$VERSION_NAME" ] && [ ! -d "$NODENV_ROOT/versions/$VERSION_NAME" ] && [ -f "$(nodenv-aliases --definitions_path)/$VERSION_NAME" ]; then
    local ALIASES
    IFS=" " read -ra ALIASES <<< "$(nodenv-aliases --resolve_aliases "$VERSION_NAME")"

    local ALIAS

    for ALIAS in "${ALIASES[@]}"; do
      if [ -L "$NODENV_ROOT/versions/$ALIAS" ]; then
        rm -f "$NODENV_ROOT/versions/$ALIAS"
        echo "Unalias: $ALIAS"
      fi
    done
  fi
}

before_uninstall resolve_versions

after_uninstall unalias_versions
