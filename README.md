# zemu
> A dead simple plugin for managing `qemu` configurations

This plugin will define a configuration directory at `.config/qemu` (or whatever you set `$QEMU_CONFIG` to).
Within are files of the form `[guest].conf` which are the `ini` files outputted by `qemu`'s `-writeconfig`
option.

To run a VM, use
```bash
zemu [guest]
```

## Installation
### Using [zplug](https://github.com/zplug/zplug)
Add to your `.zshrc`:
```bash
zplug "cjayross/zemu"
```
### Using [zgen](https://github.com/tarjoilija/zgen)
Add to your `.zshrc`:
```bash
zgen load cjayross/zemu
zgen save
```

### Using [Antigen](https://github.com/zsh-users/antigen)
Add to your `.zshrc`:
```bash
antigen bundle cjayross/zemu
antigen apply
```

