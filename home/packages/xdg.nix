{ pkgs, lib, ... }:

{
  xdg.desktopEntries = {
    OrcaSlicer = {
      name = "OrcaSlicer";
      genericName = "3D Printing Software";
      icon = "orcaslicer";
      exec = lib.concatStringsSep " " [
        "${pkgs.coreutils}/bin/env"
        "__GLX_VENDOR_LIBRARY_NAME=mesa"
        "__EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json"
        "MESA_LOADER_DRIVER_OVERRIDE=zink"
        "GALLIUM_DRIVER=zink"
        "WEBKIT_DISABLE_DMABUF_RENDERER=1"
        "${lib.getExe pkgs.orca-slicer} %U"
      ];
      terminal = false;
      type = "Application";
      mimeType = [
        "model/stl"
        "model/3mf"
        "application/vnd.ms-3mfdocument"
        "application/prs.wavefront-obj"
        "application/x-amf"
      ];
      categories = [ "Graphics" "3DGraphics" "Engineering" ];
      startupNotify = false;
    };
  };
}
