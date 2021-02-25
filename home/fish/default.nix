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
        rev = "a2ad38aa051aaed25ae3bd6129986e7f27d42d7b";
        sha256 = "1fssb5bqd2d7856gsylf93d28n3rw4rlqkhbg120j5ng27c7v7lq";
      };
    }
  ];
};

xdg.configFile."fish/functions".source = ./functions;
xdg.configFile."fish/conf.d/plugin-bobthefish.fish".text = lib.mkAfter ''
  for f in $plugin_dir/*.fish
    source $f
  end
  '';
}
