# Fish Virtuoso

This plugin tries to optimize how `fish` interacts with `nvim` and `tmux`,
in a way that is backwards-compatible with `vim` and `vi`. The plugin
is perhaps especially interesting for people who use `nvr`.

## Motivation

If you want the following functionality, then this plugin is for you:

- Automatically select the best available `$EDITOR` when `fish` starts.
  I realize that "best" is very subjective, but in my opinion the order
  should be `nvr`, `nvim`, `vim`, `vi`. The options to the left are used 
  if available, but more hosts are likely to have the ones on the right.
  Due to the how the `nvr` integration is done, this is only chosen as
  your `$EDITOR` if you start `fish` inside either `nvim` or `tmux`.  
- Provide the same editing commands in the shell as in `vim` command mode.
  In other words, the commands `edit`, `split`, `vsplit`, and `tabedit`
  (and their abbreviations `e`, `sp`, `vs`, `tabe`) should do the same 
  thing in `fish` and `vim`. If your `$EDITOR` is `nvr`, these actions
  are performed in an existing `nvim` instance.
- Integrate the excellent [NeoVim Remote][1] in a smart way. If you use
  `nvr` within the built-in terminal of `nvim`, this means that the 
  surrounding `nvim` is used. If you run `nvr` inside `tmux`, the
  assumption is that you only want one `nvim` instance per `tmux` window,
  so the currently visible `nvim` instance in your `tmux` window is reused.
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

## Acknowledgements 

The `nvr` integration is strongly inspired by [this thread][3] on Reddit.

[3]: https://www.reddit.com/r/neovim/comments/aex45u/integrating_nvr_and_tmux_to_use_a_single_tmux_per/
