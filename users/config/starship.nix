{}:

''
format = """
$character\
$directory\
$hostname\
$git_branch\
$git_status\
$git_commit\
[❯](bold bright-green)[❯](bold bright-yellow)[❯](bold bright-red)[ | ](bold bright-black)\

"""

add_newline = true

[directory]
format = "[█](fg:bright-black bg:none)[$path]($style)[█ ](fg:bright-black bg:none)"
style = "fg:bold bright-white bg:bright-black"
truncation_length = 3
truncate_to_repo = false
read_only = " "

[character]
format = "$symbol"

success_symbol = "[](fg:bright-black bg:none)[ 󰉋  ](fg:blue bg:bright-black)[](fg:bright-black bg:none)"

error_symbol = "[](fg:bold bright-black bg:none)[ 󰉋  ](fg:red bg:bright-black)[](fg:bold bright-black bg:none)"

[line_break]
disabled = true
'' 