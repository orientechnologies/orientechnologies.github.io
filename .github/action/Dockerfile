from rust:latest
MAINTAINER Tglman<tglman@tglman.com>

LABEL "com.github.actions.name"="OrientDB Site Deploy"
LABEL "com.github.actions.description"="OrientDB Site Deploy"
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="green"

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && apt-get install -y wget git

RUN git clone https://github.com/getzola/zola.git zola

RUN cd zola && git checkout v0.15.2 && cargo install --path .

RUN cd ..

RUN cargo install mdbook && cargo install mdbook-variables

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
