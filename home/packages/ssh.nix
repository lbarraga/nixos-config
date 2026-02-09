{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # https://github.com/nix-community/home-manager/blob/0d782ee42c86b196acff08acfbf41bb7d13eed5b/modules/programs/ssh.nix#L555-L578
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "no";
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
  };
}
