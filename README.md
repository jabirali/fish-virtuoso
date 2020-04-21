# Fish Virtuoso

This plugin tries to optimize how `fish` interacts with `nvim` and `tmux`,
with fallback functionality for when you need to use `vim` or `vi`.

## Motivation

If you want the following functionality, then this plugin is for you:

- Automatically select the best available `$EDITOR` when `fish` starts.
  I realize that "best" is very subjective, but in my opinion the order
  should be `nvr`, `nvim`, `vim`, `vi`. The options to the left are used 
  if available, but more hosts are likely to have the ones on the right.
- Provide the same editing commands in the shell as in `vim` command mode.
  In other words, the commands `edit`, `split`, `vsplit`, and `tabedit`
  (and their abbreviations `e`, `sp`, `vs`, `tabe`) should do the same 
  thing as the corresponding commands in `vim`. If your `$EDITOR` is 
  `nvr`, these actions may be performed in an existing `nvim` instance.
- Integrate the excellent [NeoVim Remote][1] with `tmux`. The assumption 
  here is that if you use `nvr` as your `$EDITOR` within `tmux`, you only 
  want *one* `nvim` instance per `tmux` session and window. Thus, typing
  `split /etc/fstab` in a `tmux` window that has an `nvim` instance visible
  will open the file `/etc/fstab` in a new `:split` in that `nvim` instance.
- To help you start typing `e` or `edit` instead of `nvr`/`nvim`/`vim`/`vi`,
  since the latter are inherently less portable, I have also added some
  abbreviations that help with the transition. If anyone is offended by
  this, please let me know, and I can add an option to disable these...

[1]: https://github.com/mhinz/neovim-remote

## Quickstart

The easiest way to install this is using [fisher][2]:

	fisher add jabirali/fish-virtuoso

Restart `fish`, and everything should work by itself. 
If it doesn't, feel free to open an issue on Github!

[2]: https://github.com/jorgebucaran/fisher
