{
  character = {
    error_symbol = "[](bold red)";
    success_symbol = "[](bold green)";
    vicmd_symbol = "[](bold yellow)";
    format = "$symbol [|](bold bright-black) ";
  };

# El truco ''$ evita que Nix crasheé y le pasa la sintaxis correcta a Starship
  format = "[](bg:#3B4B58 fg:#3B4B58)[ uwu ](bg:#3B4B58 fg:#9DFAAA)[](fg:#3B4B58)[ $ ](bold yellow)$directory$git_branch";
  add_newline = false;

  custom.uwu_block = {
    command = "echo ' uwu '"; 
    style = "bg:#3B4B58 fg:#9DFAAA";
    when = "true";
  };

  hostname = {
    ssh_only = true;
    format = "[$hostname](bold blue) ";
    disabled = false;
  };

  line_break.disabled = true;
  directory.disabled = true;
  nodejs.disabled = true;
  nix_shell.symbol = "[](blue) ";
  python.symbol = "[](blue) ";
  rust.symbol = "[](red) ";
  lua.symbol = "[](blue) ";
  package.symbol = "📦  ";
}