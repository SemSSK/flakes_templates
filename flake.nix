{
  description = "Simple and personal template for Rust projects";
  outputs = { self, ... }: {
    templates = {
      haskell = {
        description = ''
          declares basic stuff needed in a barebone haskell project
        '';
        path = ./haskellMinimalProject;
      };
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
      cppBasic = {
        description = ''
          declares basic stuff needed in a basic cpp project with only compiler
        '';
        path = ./cppBasicProject;
      };

      egui = {
        description = ''
          declares basic stuff needed in an egui using rust project
        '';
        path = ./rustEguiProject;
      };
      tauri = {
        description = ''
          declares basic stuff needed in an tauri using rust project
        '';
        path = ./rustTauriProject;
      };
      fltk = {
        description = ''
          declares basic stuff needed in an fltk using rust project
        '';
        path = ./rustFltkProject;
      };
      tuiCursive = {
        description = ''
          declares basic stuff needed in an tui using rust and ncurses project
        '';
        path = ./rustTuiCursiveProject;
      };
    };
  };
}
