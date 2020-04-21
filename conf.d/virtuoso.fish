# Autoselect the best $EDITOR {{{
	if type -q nvr
		if [ -n "$TMUX" ] || [ -n "$NVIM_LISTEN_ADDRESS" ]
			set -x EDITOR nvr
		else
			set -x EDITOR nvim
		end
	else if type -q nvim
		set -x EDITOR nvim
	else if type -q vim
		set -x EDITOR vim
	else
		set -x EDITOR vi
	end
# }}}

# Simplify the use of $EDITOR {{{
	if [ "$EDITOR" = "nvr" ]
		# When the $EDITOR is set to `nvr`, we can define different functions 
		# for accessing a file via `:edit`, `:split`, `:vsplit`, and `:tabedit`.
		function edit -w nvr
			nvr $argv 2> /dev/null
		end
		
		function split -w nvr
			nvr -cc split $argv 2> /dev/null
		end
		
		function vsplit -w nvr
			nvr -cc split $argv 2> /dev/null
		end
		
		function tabedit -w nvr
			nvr -cc split $argv 2> /dev/null
		end
	else
		# When the $EDITOR is not `nvr`, the best we can do is to is to open the
		# specified files in a new instance as separate splits, vsplits, or tabs.
		function edit -w $EDITOR
			$EDITOR $argv
		end
		
		function split -w $EDITOR
			$EDITOR -o $argv
		end
		
		function vsplit -w $EDITOR
			$EDITOR -O $argv
		end
		
		function tabedit -w $EDITOR
			$EDITOR -p $argv
		end
	end
	
	# Replicate the Vim short-hand commands.
	abbr -ga e  edit
	abbr -ga sp split
	abbr -ga vs vsplit
	abbr -ga tabe tabedit
	
	# Force the use of $EDITOR.
	abbr -ga vi   edit
	abbr -ga vim  edit
	abbr -ga nvim edit
	abbr -ga nvr  edit
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
