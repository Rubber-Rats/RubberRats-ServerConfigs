{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "www";
  networking.domain = "rubberroomwithrats.com";

  networking.firewall.enable = false;

  #TODO autofetch the keys from our github profiles

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFecTaDusQuqN5tWYitmFMqZEbBMeZA8SWLKOtlLE5tI psychopathy@psychopathy-desktop''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL5432hWcdfQX8icuV1W4xV63NB9uQ4yUaJztTXX5qdT''
  ];


  #PROSODY SERVER

  #NGINX
  services.nginx = {
    enable = true;
   #Recomended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    
    virtualHosts."localhost" = {

      root = "/var/www/www.rubberroomwithrats.com";

    };
  };
 
  # acme setup
  security.acme = {
    email = "root@rubberroomwithrats.com";
    acceptTerms = true;
    certs = {
      "rubberroomwithrats.com" = {
       webroot = "/var/www/www.rubberroomwithrats.com";
       email = "root@rubberroomwithrats.com";
       extraDomainNames = [ 
        "xmpp.rubberroomwithrats.com" 
        "conference.rubberroomwithrats.com" 
        "upload.rubberroomwithrats.com" 
        "www.rubberroomwithrats.com" 
       ];
      };
    };
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.autoUpgrade = {
    enable = true;
    flake = "github:Rubber-Rats/RubberRats-ServerConfigs";
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
 
  system.stateVersion = "23.11";
}
