{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
