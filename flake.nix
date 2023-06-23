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
    };
  };
}