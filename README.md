# node-build-aliases

## Installation

### Installing with Git

```shell
git clone https://github.com/manlao/node-build-aliases.git $(nodenv root)/plugins/node-build-aliases
```

### Installing with homebrew

```shell
brew install manlao/tap/node-build-aliases
```

## Usage

List all aliases

```shell
nodenv aliases
```

Update aliases from nodejs.org and remove aliases in $NODENV_ROOT/versions

```shell
nodenv aliases --update
```

Update aliases from nodejs.org and modify aliases in $NODENV_ROOT/versions (and auto install version if not installed)

```shell
nodenv aliases --update --upgrade
```
