# Autoselect the best $EDITOR {{{
	if type -q nvr
		if [ -n "$TMUX" ] || [ -n "$NVIM_LISTEN_ADDRESS" ]
			set -x EDITOR "nvr -s"
		else
			set -x EDITOR "nvim"
		end
	else if type -q nvim
		set -x EDITOR "nvim"
	else if type -q vim
		set -x EDITOR "vim"
	else
		set -x EDITOR "vi"
	end
# }}}

# Simplify the use of $EDITOR {{{
	# Define aliases for interacting with Vim in the same way from a shell as
	# you would do in "command mode".  The wrapper function avoids a bug if 
	# one runs `edit` with no file names (as one could start `nvim`/`vim`).
	if [ "$EDITOR" = "nvr -s" ]
		function edit -w nvr
			if [ -e "$NVIM_LISTEN_ADDRESS" ]
				nvr $argv
			else
				nvim --listen "$NVIM_LISTEN_ADDRESS" $argv
			end
		end
	else
		alias "edit" "$EDITOR"
	end
	
	alias "split"   "edit -o"
	alias "vsplit"  "edit -O"
	alias "tabedit" "edit -p"
	
	# Replicate Vim's abbreviations.
	abbr -ga "e"    "edit"
	abbr -ga "sp"   "split"
	abbr -ga "spl"  "split"
	abbr -ga "vs"   "vsplit"
	abbr -ga "vsp"  "vsplit"
	abbr -ga "vspl" "vsplit"
	abbr -ga "tabe" "tabedit"
	
	# Force the use of $EDITOR.
	abbr -ga "vi"   "edit"
	abbr -ga "vim"  "edit"
	abbr -ga "nvim" "edit"
	abbr -ga "nvr"  "edit"
# }}}

# Integrate Tmux and Neovim {{{
	# This is done by syncing the Neovim instance to the Tmux window, so
	# running `nvr` reuses a currently visible Neovim instance. Placing
	# this in the prompt keeps it up-to-date after moving panes around.
	if [ -n "$TMUX" ]
		# Ensure that the cache directory exists.
		mkdir -p ~/.cache/nvim
		
		# Make a backup of the existing prompt.
		functions -c fish_prompt _nvr_old_prompt
		
		# Update the prompt to check `tmux` window. This is done to ensure that 
		# the window information remains up to date even if the pane is relocated.
		function fish_prompt
			# Sync the `nvim` instance to the `tmux` session and window.
			set -gx NVIM_LISTEN_ADDRESS (tmux display -p '#{HOME}/.cache/nvim/nvr#{session_id}#{window_id}')
			
			# Restore the old prompt.
			_nvr_old_prompt
		end
	end
# }}}
