# DotFiles

Managed with [GNU stow](https://www.gnu.org/software/stow/). The files in
`home/` are symlinked into `$HOME`; editing either side edits the same file.

## Layout

| Path       | What it is                                               |
|------------|----------------------------------------------------------|
| `home/`    | The stow package. Mirrors `$HOME`. Everything here is linked |
| `scripts/` | Helper scripts. Not linked; called by path                |
| `nvchad/`  | NvChad customisations                                     |
| `Brewfile` | `brew bundle` manifest                                    |

Currently linked:

```
home/.zshrc                              -> ~/.zshrc
home/.zshenv                             -> ~/.zshenv
home/.zprofile                           -> ~/.zprofile
home/.tmux.conf                          -> ~/.tmux.conf
home/.ideavimrc                          -> ~/.ideavimrc
home/.config/alacritty/alacritty.toml    -> ~/.config/alacritty/alacritty.toml
home/.config/karabiner/karabiner.json    -> ~/.config/karabiner/karabiner.json
```

## Usage

```sh
brew install stow

cd ~/DotFiles
stow --no-folding -v --target="$HOME" home   # link everything
stow -D --target="$HOME" home                # unlink everything
stow -R --no-folding --target="$HOME" home   # relink after adding files
```

`--no-folding` links individual files rather than whole directories. It
matters for `~/.config`, which holds many directories this repo does not
manage — without it, stow would replace a whole config directory with a
symlink the first time it saw an unmanaged one.

## Adding a file

```sh
mv ~/.someconfig ~/DotFiles/home/.someconfig
cd ~/DotFiles && stow --no-folding --target="$HOME" home
```

## PATH ordering on macOS

`/etc/zprofile` runs `path_helper`, which rebuilds `PATH` and puts
`/etc/paths` and `/etc/paths.d/*` first. This happens *after* `~/.zshenv`,
so anything `.zshenv` prepends gets demoted. Anything that must win — the
pyenv shims, for one — has to be prepended in `~/.zprofile` instead, which
runs later. That is why `.zprofile` ends with the pyenv shims line.
