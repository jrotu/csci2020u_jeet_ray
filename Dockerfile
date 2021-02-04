FROM bitnami/minideb AS nix
RUN apt update && apt install -y curl xz-utils

# Allows me to update the Nix package manager on every build
ARG recache=0
RUN mkdir /nix /etc/nix && echo "build-users-group =" > /etc/nix/nix.conf && curl -L https://nixos.org/nix/install | sh 

# As this is a new stage, this remains unaffected by the update above, unlike using a RUN task immediately after
FROM nix
CMD [ "/usr/bin/env xonsh" ]
ENV PATH="/root/.nix-profile/bin/:${PATH}"
RUN nix-channel --update && nix-env -iA \
	nixpkgs.xonsh \
	nixpkgs.gradle \
	nixpkgs.git \
	nixpkgs.emacs \
	nixpkgs.tmux \
	nixpkgs.byobu

RUN mkdir ~/.ssh && ln -s /run/secrets/host_ssh_key ~/.ssh/id_ed25519

# Answer: https://stackoverflow.com/a/39278224
# User: https://stackoverflow.com/users/243335/anq
ADD https://api.github.com/repos/jrotu/csci2020u_jeet_ray/git/refs/heads/master version.json
RUN git clone git@github.com:jrotu/csci2020u_jeet_ray.git csci2020u
