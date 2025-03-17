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

Update aliases from nodejs.org

```shell
nodenv aliases --update
```

Update aliases from nodejs.org and upgrade installed aliases

```shell
nodenv aliases --update --upgrade
```

Update aliases from nodejs.org, upgrade installed aliases and enable corepack

```shell
nodenv aliases --update --upgrade-and-enable-corepack
```
