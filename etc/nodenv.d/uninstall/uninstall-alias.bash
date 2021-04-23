#!/usr/bin/env bash

resolve_versions() {
  if [ -L "$(nodenv-aliases --aliases_path)/$DEFINITION" ]; then
    VERSION_NAME=$(nodenv-aliases --resolve_definition "$DEFINITION")
    export VERSION_NAME
    export PREFIX="$NODENV_ROOT/versions/$VERSION_NAME"
  fi
}

unalias_versions() {
  if [ "$STATUS" -eq 0 ] && [ -n "$VERSION_NAME" ]; then
    if [ -f "$(nodenv-aliases --definitions_path)/$VERSION_NAME" ] || [ -f "$(nodenv-aliases --plugin_definitions_path)/$VERSION_NAME" ]; then
      local ALIASES ALIAS
      IFS=" " read -ra ALIASES <<< "$(nodenv-aliases --resolve_aliases "$VERSION_NAME")"

      for ALIAS in "${ALIASES[@]}"; do
        if [ -L "$NODENV_ROOT/versions/$ALIAS" ]; then
          rm -f "${NODENV_ROOT:?}/versions/${ALIAS:?}"
          echo "Unalias: $ALIAS"
        fi
      done
    fi
  fi
}

before_uninstall resolve_versions

after_uninstall unalias_versions
