{}:

''
format = """
$hostname\
$directory\
$git_branch\
$git_status\
$git_commit\
$cmd_duration\
$character"""

# Desactivar la línea en blanco al inicio del prompt
add_newline = false

# 1. HOSTNAME (Solo se muestra si estás conectado por SSH)
[hostname]
ssh_only = true 
format = "[](fg:#252525 bg:none)[█](fg:#E8E3E3 bg:#252525)[$ssh_symbol$hostname](bold bg:#E8E3E3)[](fg:#E8E3E3 bg:none) "
disabled = false

# 2. DIRECTORIO (Ruta actual)
[directory]
format = "[](fg:#22272e bg:none)[$path]($style)[█](fg:#22272e bg:#22272e)[](fg:#6791C9 bg:#22272e)[ ](fg:#22272e bg:#6791C9)[](fg:#6791C9 bg:none) "
style = "fg:#E8E3E3 bg:#22272e bold"
truncation_length = 3
truncate_to_repo = false
read_only = " "

# 3. RAMA DE GIT
[git_branch]
format = "[](fg:#252525 bg:none)[$branch]($style)[](fg:#252525 bg:#252525)[](fg:#81C19B bg:#252525)[](fg:#252525 bg:#81C19B)[](fg:#81C19B bg:none) "
style = "fg:#E8E3E3 bg:#252525"
symbol = " "

# 4. ESTADO DE GIT
[git_status]
format = "[](fg:#252525 bg:none)[$all_status$ahead_behind]($style)[](fg:#252525 bg:#252525)[](fg:#6791C9 bg:#252525)[ ](fg:#252525 bg:#6791C9)[](fg:#6791C9 bg:none) "
style = "fg:#E8E3E3 bg:#252525"
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

# 6. DURACIÓN DEL COMANDO
[cmd_duration]
min_time = 1
format = "[](fg:#252525 bg:none)[$duration]($style)[](fg:#252525 bg:#252525)[](fg:#C397D8 bg:#252525)[󱑂 ](fg:#252525 bg:#C397D8)[](fg:#C397D8 bg:none) "
disabled = false
style = "fg:#E8E3E3 bg:#252525 bold"

# 7. INDICADOR DEL PROMPT (Al final para que escribas justo aquí)
[character]
success_symbol = "[ ](#6791C9 bold)"
error_symbol = "[ ](#B66467 bold)"

[line_break]
disabled = true
''