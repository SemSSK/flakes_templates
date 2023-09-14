{
  description = "Simple and personal template for Rust projects";
  outputs = { self, ... }: {
    templates = {
      rust = {
        description = ''
          declares basic stuff needed in a barebone rust project
        '';
        path = ./rustDefaultProject;
      };
      cpp = {
        description = ''
          declares basic stuff needed in a barebone cpp project
        '';
        path = ./cppDefaultProject;
      };
      egui = {
        description = ''
          declares basic stuff needed in an egui based rust project
        '';
        path = ./rustEguiProject;
      };
      tauri = {
        description = ''
          declares basic stuff needed in an tauri based rust project
        '';
        path = ./rustTauriProject;
      };
      fltk = {
        description = ''
          declares basic stuff needed in an fltk based rust project
        '';
        path = ./rustFltkProject;
      };
    };
  };
}