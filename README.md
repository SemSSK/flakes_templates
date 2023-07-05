# flakes_templates
A bunch of projects Nix flakes a use commonly
# To create a new project use for each template
* Simple rust project:
````
  # Initializing in an already created folder
  nix flake init -t github:semssk/flakes_templates#<name of template>

  # Creating a new folder with the flake
  nix flake new <name_of_folder> -t github:semssk/flakes_templates#rust<name of template>

````
# List of templates
* rust : Basic rust project
* egui : Native Desktop application using egui 
