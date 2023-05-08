{pkgs ? (import <nixpkgs>), ...}:

with pkgs;
{
programs.fish = {
  enable = true;
  plugins = [
    {
      name = "bobthefish";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "theme-bobthefish";
        rev = "ed896b65c3ddbdf2929c38719adfb940b0d9b90d";
        sha256 = "DRMBZS8nT0rhKXQEGWNqR1FUavtvxH0xUdHU52WhSJQ=";
      };
    }
  ];
  interactiveShellInit = ''
  any-nix-shell fish --info-right | source
  direnv hook fish | source
  '';
};

xdg.configFile."fish/functions".source = ./functions;
}
