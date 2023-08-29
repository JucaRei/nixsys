{lib, ...}: {
  ########################
  ### Default Timezone ###
  ########################

  services.xserver.layout =
    if (builtins.isString == "nitro")
    then "br"
    else "us";
  time.timeZone = lib.mkDefault "America/Sao_Paulo";
  #location = {
  #  latitude = -23.539380;
  #  longitude = -46.652530;
  #};
}
