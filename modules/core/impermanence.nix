{inputs, ...}: {
  den.aspects.impermanence = {
    nixos = {
      imports = [inputs.impermanence.nixosModules.impermanence];

      environment.persistence."/persist" = {
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/lib/bluetooth"
          "/var/lib/netbird"
          "/etc/NetworkManager/system-connections"
          "/var/lib/docker"
          "/var/lib/sops-nix"
          "/etc/ssh"
        ];
        files = [
          "/etc/machine-id"
          "/etc/shadow"
        ];
      };
      programs.fuse.userAllowOther = true;
    };

    homeManager = {
      imports = [inputs.impermanence.nixosModules.home-manager.impermanence];

      home.persistence."/persist/home/lukasbt" = {
        directories = [
          # --- STANDARD & CLOUD ---
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
          "Public"
          "Templates"
          "Drive"
          ".SynologyDrive"
          ".local/share/SynologyDrive"
          ".config/SynologyDrive"

          # --- PROJECTS ---
          "nix-config"

          # --- SECURITY & KEYS ---
          ".ssh"
          ".gnupg"
          ".local/share/keyrings"

          # --- BROWSERS & COMMUNICATION ---
          ".config/BraveSoftware"
          ".config/discord"

          # --- DEVELOPMENT ---
          ".config/github-copilot"
          ".cargo"
          ".npm"
          ".local/share/nvim"
          ".local/state/nvim"

          # --- GAMING & 3D PRINTING ---
          ".local/share/Steam"
          ".steam"
          ".config/OrcaSlicer"

          # --- PERSONAL & PRODUCTIVITY ---
          ".config/obsidian"
          ".config/spotify"
          ".local/share/Anki2"
          ".config/xournalpp"

          # --- SYSTEM CACHES & CLI ---
          ".local/share/zsh"
          ".local/share/direnv"
          ".local/state/home-manager"
          ".cache/nix"
        ];

        files = [
          ".zsh_history"
        ];

        allowOther = true;
      };
    };
  };
}
