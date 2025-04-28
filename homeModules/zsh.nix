{pkgs, ...}:
{
  home.packages = [
    pkgs.pure-prompt
  ];

  programs.zsh = {
    enable = true;
    # enableCompletions = true;
    # autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .";
      rebuild-home = "home-manager switch --flake .";

      ls = "ls --color=auto -h --group-directories-first";
      ll = "ls -l";
      rr = "rm -r";

      gca = "git commit -a";
      gsm = "git push origin main";
      glm = "git pull origin main";

      hibernate = "systemctl hibernate";
    };

    history.size = 10000;

    initExtra = ''
      fpath+=(${pkgs.pure-prompt}/share/zsh/site-functions)
      autoload -U promptinit && promptinit
      prompt pure

      bindkey -v
      bindkey -M vicmd ':' vi-cmd-mode
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char
    '';
  };
}
