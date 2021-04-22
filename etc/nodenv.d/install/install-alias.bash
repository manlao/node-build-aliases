#!/usr/bin/env bash

resolve_versions() {
  if nodenv commands | grep "update-version-defs" 1>/dev/null 2>&1; then
    NODE_BUILD_DEFINITIONS="$(nodenv-aliases --plugin_definitions_path):$NODE_BUILD_DEFINITIONS"
    export NODE_BUILD_DEFINITIONS
  fi

  if [ -L "$(nodenv-aliases --aliases_path)/$DEFINITION" ]; then
    VERSION_NAME=$(nodenv-aliases --resolve_definition "$DEFINITION")
    export VERSION_NAME
    export PREFIX="$NODENV_ROOT/versions/$VERSION_NAME"
    export DEFINITION="$VERSION_NAME"

    if [ -d "$PREFIX" ] && [ -d "${PREFIX}/bin" ]; then
      if [ -z "$FORCE" ] && [ -z "$SKIP_EXISTING" ]; then
        echo "nodenv: $PREFIX already exists" >&2
        read -rp "continue with installation? (y/N) "

        case "$REPLY" in
          y* | Y* )
            ;;
          * )
            exit 1 ;;
        esac
      elif [ -n "$SKIP_EXISTING" ]; then
        exit 0
      fi
    fi
  fi
}

alias_versions() {
  if [ "$STATUS" -eq 0 ] && [ -n "$VERSION_NAME" ]; then
    if [ -f "$(nodenv-aliases --definitions_path)/$VERSION_NAME" ] || [ -f "$(nodenv-aliases --plugin_definitions_path)/$VERSION_NAME" ]; then
      local ALIASES ALIAS
      IFS=" " read -ra ALIASES <<< "$(nodenv-aliases --resolve_aliases "$VERSION_NAME")"

      for ALIAS in "${ALIASES[@]}"; do
        if [ -n "$ALIAS" ]; then
          mkdir -p "$(dirname "$NODENV_ROOT/versions/$ALIAS")"
          ln -sf "${PREFIX:-$NODENV_ROOT/versions/$VERSION_NAME}" "$NODENV_ROOT/versions/$ALIAS"
          echo "Alias: $ALIAS -> $VERSION_NAME"
        fi
      done
    fi
  fi
}

before_install resolve_versions

after_install alias_versions
