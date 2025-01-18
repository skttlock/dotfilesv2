{pkgs, ...}: {
  # Install fonts
  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
    inriafonts
    arcticons-sans
    junction-font
    prociono
    poly
  ];
}
