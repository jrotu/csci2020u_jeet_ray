FROM nixos/nix
CMD [ "/usr/bin/env", "xonsh" ]
WORKDIR /root

# Unnecessary when using the nixos/nix image, but isn't much of a hinderance
ENV PATH="/root/.nix-profile/bin/:${PATH}"

RUN nix-channel --update && nix-env -iA \
	nixpkgs.xonsh \
	nixpkgs.gradle \
	nixpkgs.emacs \
	nixpkgs.tmux \
	nixpkgs.byobu \
	nixpkgs.rsync \
	nixpkgs.git && git config --global user.name "Jeet Ray" && git config --global user.email "jeet.ray@ontariotechu.net"

# Answer: https://stackoverflow.com/a/39278224
# User: https://stackoverflow.com/users/243335/anq
ARG user="jrotu"
ARG repo="csci2020u"
ARG frepo="${repo}_jeet_ray"
ARG branch="master"

ADD https://api.github.com/repos/$user/$frepo/git/refs/heads/$branch version.json
RUN git clone -b $branch git@github.com:$user/$frepo.git /root/$repo
