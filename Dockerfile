# ---- Build Stage ----
FROM elixir:1.9.0-alpine AS app_builder

# install build dependencies
RUN apk add --update git build-base nodejs nodejs-npm

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set environment variables for building the application
ARG ENV_SECRET_KEY_BASE="secrete_key"
ENV SECRET_KEY_BASE=${ENV_SECRET_KEY_BASE}
ENV LANG=C.UTF-8

# Copy over all the necessary application files and directories
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY assets ./assets
COPY mix.exs mix.lock ./

ARG ENV_DEPLOY
ENV ENV_DEPLOY $ENV_DEPLOY
RUN echo $ENV_DEPLOY

# Fetch the application dependencies and build the application
RUN mix deps.get
RUN mix deps.compile
RUN cd assets && npm install && npm rebuild node-sass && npm run deploy
RUN mix phx.digest
RUN mix compile
RUN MIX_ENV=$ENV_DEPLOY
RUN mix release

# ---- Application Stage ----
FROM alpine:3.9

ENV LANG=C.UTF-8
ENV HOME=/app

# Install openssl
RUN apk add --update bash openssl ncurses-libs postgresql-client && \
    rm -rf /var/cache/apk/*

RUN mkdir /app
WORKDIR /app

COPY --from=app_builder /app/_build/prod/rel/sapanboon ./
RUN chown -R nobody: /app
USER nobody
