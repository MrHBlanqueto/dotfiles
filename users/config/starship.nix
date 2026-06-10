{}:

''
format = """
$character\
$hostname\
$directory\
$git_branch\
$git_status\
$git_commit\
[ |](bold bright-black)[❯](bold bright-green)[❯](bold bright-yellow)[❯](bold bright-red) \

"""

add_newline = false

# 1. HOSTNAME
[hostname]
ssh_only = true 
format = "[](fg:black bg:none)[█](fg:white bg:black)[$ssh_symbol$hostname](bold bg:white)[](fg:white bg:none)"
disabled = false

# 2. DIRECTORIO
[directory]
format = "[](fg:bright-black bg:none)[$path]($style)[█](fg:bright-black bg:bright-black)"
style = "fg:white bg:bright-black bold"
truncation_length = 3
truncate_to_repo = false
read_only = " "

# 3. RAMA DE GIT
[git_branch]
format = "[](fg:black bg:none)[$branch]($style)[](fg:black bg:black)[](fg:green bg:black)[](fg:black bg:green)[](fg:green bg:none) "
style = "fg:white bg:black"
symbol = " "

# 4. ESTADO DE GIT
[git_status]
format = "[](fg:black bg:none)[$all_status$ahead_behind]($style)[](fg:black bg:black)[](fg:blue bg:black)[ ](fg:black bg:blue)[](fg:blue bg:none) "
style = "fg:white bg:black"
conflicted = "="
ahead = "⇡''${count}"
behind = "⇣''${count}"
diverged = "⇕⇡''${ahead_count}⇣''${behind_count}"
up_to_date = " 󰄸 "
untracked = "?''${count}"
stashed = ""
modified = "!''${count}"
staged = "+''${count}"
renamed = "»''${count}"
deleted = " ''${count}"

# 5. COMMIT DE GIT
[git_commit]
format = "[$hash]($style) [$tag]($style) "
style = "green"

[character]
format = "$symbol "

# ESTADO 1: Verde si el comando anterior fue BIEN (Modo Insertar por defecto)
success_symbol = "[ ](blue)"

# ESTADO 2: Rojo si el comando anterior fue MAL
error_symbol = "[ ](red)"

[line_break]
disabled = true
''