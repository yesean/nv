FROM alpine:edge
WORKDIR /root

RUN apk add --no-cache git go openjdk8 python3 py3-pip nodejs npm neovim ripgrep alpine-sdk \
  && pip3 install -U --no-cache-dir pylint isort yapf
COPY . .config/nvim
COPY main.* .
CMD [ "nvim" ]
