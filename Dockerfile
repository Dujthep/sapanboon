FROM elixir:1.9.0-alpine as build

# install build dependencies
RUN apk add --update git build-base nodejs nodejs-npm

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

ARG ENV_DEPLOY
ENV ENV_DEPLOY $ENV_DEPLOY
RUN echo $ENV_DEPLOY

# set build ENV
ENV MIX_ENV=beta

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get
RUN mix deps.compile

# build assets
COPY assets assets
RUN cd assets && npm install && npm rebuild node-sass && npm run deploy
RUN mix phx.digest

# build project
COPY priv priv
COPY lib lib
RUN mix compile

# build release
RUN mix release

# release stage
FROM alpine:3.9

#install bash
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/beta/rel/sapanboon ./
RUN chown -R nobody: /app
USER nobody