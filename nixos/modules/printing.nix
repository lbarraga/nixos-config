{
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Home printer
  hardware.printers = {
    ensurePrinters = [{
      name = "Epson";
      location = "Home";
      deviceUri =
        "dnssd://EPSON%20ET-2870%20Series._ipp._tcp.local/?uuid=cfe92100-67c4-11d4-a45f-64c6d2474a5b";
      model = "everywhere";
      ppdOptions = { PageSize = "A4"; };
    }];
    ensureDefaultPrinter = "Epson";
  };
}
