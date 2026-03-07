{ inputs, ... }:

{
  flake.modules.nixos.llm = {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.llm ];
  };

  flake.modules.homeManager.llm =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # llama.cpp with NVIDIA GPU acceleration enabled
        (llama-cpp.override { cudaSupport = true; })

        # Python tool that includes huggingface-cli for easy model downloading
        python3Packages.huggingface-hub
      ];
    };
}
