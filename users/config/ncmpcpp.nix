{ config, pkgs, ... }:

{

  services = {
    mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Música"; # Asegúrate de que termine en "Música"
      playlistDirectory = "${config.home.homeDirectory}/.config/mpd/playlists";
      dataDir = "${config.home.homeDirectory}/.config/mpd";
  
      extraConfig = ''
          audio_output {
          type        "pipewire"
          name        "PipeWire Sound Server"
        }

          audio_output {
          type        "fifo"
          name        "my_fifo"
          path        "/tmp/mpd.fifo"
          format      "44100:16:2"
        }'';
    };
  };

  programs = {

    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override { visualizerSupport = true; };
      settings = {
        ncmpcpp_directory = "${config.home.homeDirectory}/.config/ncmpcpp";
        lyrics_directory = "${config.home.homeDirectory}/.config/ncmpcpp/lyrics";
        mpd_host = "127.0.0.1";
        mpd_port = 6600; 
        mpd_connection_timeout = 60;
    
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_output_name = "my_fifo";
        visualizer_in_stereo = "yes";
        visualizer_type = "ellipse"; 
        visualizer_look = "●●";
    
        playlist_display_mode = "columns";
        browser_display_mode = "columns";
        user_interface = "classic";

        startup_screen = "playlist";
        locked_screen_width_part = "50";
        ask_for_locked_screen_width_part = "yes";

        header_visibility = "no";
        autocenter_mode = "yes";
        centered_cursor = "yes";
        mouse_support = "yes";

        progressbar_look = "━●━";
        progressbar_color = "black";
        progressbar_elapsed_color = "white";

        empty_tag_marker = " ";
        window_border_color = "black";
        active_window_border = "black";

        song_status_format = "$1[ %a ] %b - %t";
        song_columns_list_format = "(53)[white]{tr} (45)[white]{a}";
        song_library_format = "{{%a - %t} (%b)}|{%f}";

        now_playing_prefix = "$b$2$7 ";
        now_playing_suffix = "  $/b$8";
        current_item_prefix = "$b$7$/b$3 ";
        current_item_suffix = "  $4";
      };
    };
  };
}
