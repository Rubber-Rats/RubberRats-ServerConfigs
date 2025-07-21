#Test commit

{ config, lib, pkgs, ... }: 
let
  domain = "rubberroomwithrats.com";
in
{
  imports = [
    ./hardware-configuration.nix
    # TODO enable hardened profile
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "www";
  networking.domain = domain;


  networking.firewall.enable = false;

  #TODO autofetch the keys from our github profiles

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
	# psychopathy@nixos
	''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJRWdABQs9syII/zeGF/+OxDxeAoEWJAZmC7sZx+Xq3C psychopathy@nixos''
	''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4GDpHEBs3WoCv/o3+xXhXiOD/3VjQXhTx4RjVS/woE JuiceSSH''
  # mutablefigment@nixos
	''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALgZwOAX8Jn1YKDOHQ8fZbz+Iwb7KhwKpL1hbMChzaS''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/W2zkTZRQwLP/wkC5kg+Us3yfpraj/XRNCgGfSBx0a''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIOU+iWnGXqMpNj5wZOXN7/IpEz7Cavarzs2rM7RS/aq''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYjXcyA/YHzObqmY1wFH/cHduIgywYurL6qFG+SGI4j''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmtUHk5zuyjUfFsmBLENXyfDokxwui80/CFnTxxONox''
        ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEk6oMSWZCP9u8Gi7cqmTpSVEsxeZwUSu+bK2+MR8BPb''
  ];
users.users.nix = {
    isNormalUser = true; # Marks it as a regular user
    extraGroups = [ "wheel" ]; # Grants sudo privileges
    # It's good practice to set a password hash, even if using SSH keys.
    # Generate this with 'mkpasswd -m sha-512' on your server.
    # If you leave this out, the user will have no password initially,
    # and you'll need to set one with `sudo passwd nix` after creation.
    # initialHashedPassword = "$6$SOME_SALT$SOME_HASH_FROM_MKPASSWD";
    description = "Non-root user for NixOS administration"; # Optional description

    # Assign the same SSH keys to the 'nix' user
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJRWdABQs9syII/zeGF/+OxDxeAoEWJAZmC7sZx+Xq3C psychopathy@nixos''
      	''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4GDpHEBs3WoCv/o3+xXhXiOD/3VjQXhTx4RjVS/woE JuiceSSH''

      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALgZwOAX8Jn1YKDOHQ8fZbz+Iwb7KhwKpL1hbMChzaS''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/W2zkTZRQwLP/wkC5kg+Us3yfpraj/XRNCgGfSBx0a''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIOU+iWnGXqMpNj5wZOXN7/IpEz7Cavarzs2rM7RS/aq''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYjXcyA/YHzObqmY1wFH/cHduIgywYurL6qFG+SGI4j''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmtUHk5zuyjUfFsmBLENXyfDokxwui80/CFnTxxONox''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEk6oMSWZCP9u8Gi7cqmTpSVEsxeZwUSu+bK2+MR8BPb''
    ];
  };


  #NGINX
  # services.nginx = {
  #   enable = true;
  #   #Recomended settings
  #   recommendedGzipSettings = true;
  #   recommendedOptimisation = true;
  #   recommendedProxySettings = true;
  #   recommendedTlsSettings = true;
    
  #   virtualHosts."${domain}" = {
  #       forceSSL = true;
  #       enableACME = true;
  #       serverAliases = [ "upload.${domain}" "conference.${domain}" "xmpp.${domain}" "www.${domain}"];
  #       locations."/" = {
  #         root = "/var/www/${domain}";
  #       };
  #     };
  # };
 
  # # acme setup
  # security.acme = {
  #   enable = false;
  #   email = "root@${domain}";
  #   acceptTerms = true;
  #   # certs = {
  #   #   "rubberroomwithrats.com" = {
  #   #    webroot = "/var/www/www.rubberroomwithrats.com";
  #   #    email = "root@rubberroomwithrats.com";
  #   #    extraDomainNames = [ 
  #   #     "xmpp.rubberroomwithrats.com" 
  #   #     "conference.rubberroomwithrats.com" 
  #   #     "upload.rubberroomwithrats.com" 
  #   #     "www.rubberroomwithrats.com" 
  #   #    ];
  #   #   };
  #   # };
  # };

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
