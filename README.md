# dotfiles

Usage:

```console
$ git clone --recurse-submodules https://github.com/tianon/home.git ~/somewhere/useful/and/permanent # (you don't want to have to move this after install)
$ ~/somewhere/useful/and/permanent/install.sh
$ # profit
```

If you ever `git pull`, be sure to update submodules too (`git submodule update`).

If there are new features added to `install.sh`, it is intended to be idempotent, so feel free to run it again and it should ensure that all functionality is installed and enabled.

(You'll probably also want to create `git-config.d/personal` and include `user.name` and `user.email` in it, if they don't already exist in your `~/.gitconfig`!)
