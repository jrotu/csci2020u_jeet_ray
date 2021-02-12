FROM alpine AS pre
RUN apk add git sd
RUN git clone https://github.com/shadowrylander/shadowrylander.git
RUN git clone --depth 1 https://github.com/hlissner/doom-emacs .emacs.d
RUN sd ../packages packages shadowrylander/.home/.emacs-configs/config.el
RUN sd ../global/config.el global/config.el shadowrylander/.home/.emacs-configs/.doom.d/config.el
RUN sd ../global/init.el global/init.el shadowrylander/.home/.emacs-configs/.doom.d/init.el

FROM nixos/nix
WORKDIR /root
COPY --from=pre shadowrylander/.home/.emacs-configs/.doom.d .doom.d
COPY --from=pre shadowrylander/.home/.emacs-configs/global global
COPY --from=pre .emacs.d .emacs.d

CMD [ "/usr/bin/env", "xonsh" ]

ARG n="nixpkgs"
ARG install="nix-env -iA ${n}"
RUN nix-channel --update
RUN $install.xonsh
RUN $install.rsync
RUN $install.git && git config --global user.name "Jeet Ray" && git config --global user.email "jeet.ray@ontariotechu.net"
RUN $install.emacs-nox && .emacs.d/bin/doom sync
RUN $install.tmux $n.byobu
RUN $install.gradle

ARG user="jrotu"
ARG repo="csci2020u"
ARG frepo="${repo}_jeet_ray"
ARG branch="master"

ADD https://api.github.com/repos/$user/$frepo/git/refs/heads/$branch version.json
RUN git clone -b $branch git@github.com:$user/$frepo.git $repo
