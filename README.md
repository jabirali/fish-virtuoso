# Fish Virtuoso

This plugin optimizes how `fish` interacts with `nvim` and `tmux`,
in a way that is backwards-compatible with `vim` and `vi`. The plugin
provides extra integration for those who use the [Neovim Remote][1].

## Motivation

If you want the following functionality, then this plugin is for you:

- Automatically select the best available `$EDITOR` when `fish` starts.
  I realize that "best" is subjective, but in my opinion the order
  should be `nvr`, `nvim`, `vim`, `vi`. The options to the left are used 
  if available, but more hosts have the ones to the right. Due to the how
  the integration is done, `nvr` is only chosen as `$EDITOR` if you start
  `fish` inside `nvim` or `tmux`.  
- Provide the same editing commands in the shell as in `vim` command mode.
  In other words, the commands `edit`, `split`, `vsplit`, and `tabedit`
  (and their abbreviations `e`, `sp`, `vs`, `tabe`) should do the same 
  thing in `fish` and `vim`. If your `$EDITOR` is `nvr`, these actions
  are performed in an existing `nvim` instance.
- Integrate the excellent [Neovim Remote][1] in a smart way. If you use
  `nvr` within the built-in terminal of `nvim`, this means that the 
  surrounding `nvim` is used. If you run `nvr` inside `tmux`, the
  assumption is that you only want one `nvim` instance per `tmux` window,
  so the currently visible `nvim` instance in your `tmux` window is reused.
- To help you start typing `e` or `edit` instead of `nvr`/`nvim`/`vim`/`vi`,
  since the latter are less portable, I added some abbreviations that help. 
  If you dislike this, let me know, and I can add an option to disable them.

[1]: https://github.com/mhinz/neovim-remote

## Quickstart

The easiest way to install this is using [fisher][2]:

	fisher add jabirali/fish-virtuoso

Restart `fish`, and everything should work by itself. 
If it doesn't, feel free to open an issue on Github!

The plugin works particularly well with the [Neovim Remote][1], both for people 
who use `nvim` inside `tmux`, and for people who use the built-in `nvim` terminal.
The easiest way to install this software is to use the Python package manager `pip`:

    pip3 install neovim-remote

Remember to check that your `pip` install path (e.g. `~/.local/bin`) is in `$PATH`.

[2]: https://github.com/jorgebucaran/fisher

## Known issues

If you use `nvr` inside `tmux`, and `nvim` is killed in an improper way, you
may run into issues once you try to restart `nvr` in the same `tmux` window.
This is because the files `~/.cache/nvim/nvr*` used by the `nvim` session
will not have been cleaned up properly. If this happens, just remove the
relevant file, e.g. `~/.cache/nvim/nvr$1@2` for `tmux` session 1 window 2.
If you're unsure what file to remove, just run `echo $NVIM_LISTEN_ADDRESS`.

## Acknowledgements 

The `nvr` integration is strongly inspired by [this thread][3] on Reddit.

[3]: https://www.reddit.com/r/neovim/comments/aex45u/integrating_nvr_and_tmux_to_use_a_single_tmux_per/
