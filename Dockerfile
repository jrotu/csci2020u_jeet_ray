# FROM bitnami/minideb AS nix
# RUN apt update && apt install -y curl xz-utils

# Allows me to update the Nix package manager on every build
# ARG recache=0
# RUN mkdir /nix /etc/nix && echo "build-users-group =" > /etc/nix/nix.conf && curl -L https://nixos.org/nix/install | sh 

# As this is a new stage, this remains unaffected by the update above, unlike using a RUN task immediately after
# FROM nix
FROM nixos/nix
CMD [ "/usr/bin/env", "xonsh" ]
WORKDIR /root
# ENV PATH="/root/.nix-profile/bin/:${PATH}"
RUN nix-channel --update && nix-env -iA \
	nixpkgs.xonsh \
	nixpkgs.gradle \
	nixpkgs.git \
	nixpkgs.emacs \
	nixpkgs.tmux \
	nixpkgs.byobu

# Answer: https://stackoverflow.com/a/39278224
# User: https://stackoverflow.com/users/243335/anq
ARG user="jrotu"
ARG repo="csci2020u"
ARG frepo="${repo}_jeet_ray"
ARG branch="master"

ADD https://api.github.com/repos/$user/$frepo/git/refs/heads/$branch version.json
RUN git clone -b $branch https://github.com/$user/$frepo.git /root/$repo
