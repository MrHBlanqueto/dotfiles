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
        autocenter_mode = "yes";
        centered_cursor = "yes";
        mouse_support = "yes";

        startup_screen = "visualizer";
        locked_screen_width_part = "33";
        startup_slave_screen = "playlist";
        state_line_color = "black";

        window_border_color = "default";

        progressbar_look = "━━━";
        progressbar_elapsed_color = "5";
        progressbar_color = "black";

        header_visibility = "no";
        statusbar_visibility = "yes";
        titles_visibility = "no";
        enable_window_title = "no";

        statusbar_color = "black";
        color1 = "white";
        color2 = "blue";

        song_columns_list_format = "(52)[]{t|fr:Title} (0)[magenta]{a}";
        song_list_format = " {%t $R   $8%a$8}|{%f $R   $8%l$8} $8";
        song_status_format = "$1  %a - \"%t\" - %b";
        song_window_title_format = "Now Playing ..";
      };
    };
  };
};
}