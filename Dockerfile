FROM alpine AS pre
RUN apk add git
RUN git clone https://github.com/shadowrylander/shadowrylander.git

FROM nixos/nix
WORKDIR /root
COPY --from=pre shadowrylander/.home/.emacs-configs/.doom.d .doom.d

CMD [ "/usr/bin/env", "xonsh" ]

# Unnecessary when using the nixos/nix image, but isn't much of a hinderance
ENV PATH="/root/.nix-profile/bin/:${PATH}"

ARG n="nixpkgs"
ARG install="nix-env -iA ${n}"
RUN nix-channel --update
RUN $install.xonsh
RUN $install.rsync
RUN $install.git && git config --global user.name "Jeet Ray" && git config --global user.email "jeet.ray@ontariotechu.net"
COPY --from=curl shadowrylander.tar.gz
RUN $install.emacs-nox && git clone --depth 1 https://github.com/hlissner/doom-emacs .emacs.d && tar -xf shadowrylander.tar.gz && ln -sf /root/shadowrylander/.home/.emacs-configs/.doom.d /root/.doom.d && .emacs.d/bin/doom sync
RUN $install.tmux $n.byobu
RUN $install.gradle $n.tar && tar -xf proguard.tar.gz

ARG user="jrotu"
ARG repo="csci2020u"
ARG frepo="${repo}_jeet_ray"
ARG branch="master"

ADD https://api.github.com/repos/$user/$frepo/git/refs/heads/$branch version.json
RUN git clone -b $branch git@github.com:$user/$frepo.git $repo
