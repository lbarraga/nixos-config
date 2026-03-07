{ inputs, ... }:

{
  flake.modules.nixos.llm = {
    # Enable the Open-WebUI service
    services.open-webui = {
      enable = true;
      host = "127.0.0.1";
      port = 8080;
      # openFirewall = true; # Uncomment this if you want to access the UI from your laptop/phone on the local network
    };

    home-manager.sharedModules = [ inputs.self.modules.homeManager.llm ];
  };

  flake.modules.homeManager.llm = { pkgs, ... }: {
    home.packages = with pkgs; [
      # llama.cpp with NVIDIA GPU acceleration enabled
      (llama-cpp.override { cudaSupport = true; })

      # Python tool that includes huggingface-cli for easy model downloading
      python3Packages.huggingface-hub
    ];
  };
}
