{
  den.aspects.printing3d = {
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      home.packages = [pkgs.orca-slicer];
    };
  };
}
