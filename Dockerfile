FROM rust:1.74 as BUILDER

WORKDIR /usr/src/rust-github-webhook-reciever

COPY ./src/ ./src/
COPY ./Cargo.toml ./Cargo.toml

# RUN rustup target add x86_64-unknown-linux-musl
# RUN cargo build --target x86_64-unknown-linux-musl --release

# RUN cargo build --release
RUN cargo install --path .
# RUN groupadd -r user && useradd -r -g user user

# RUN chown user:user /usr/src/rust-github-webhook-reciever/target/x86_64-unknown-linux-musl/release/rust-github-webhook-reciever


# FROM gcr.io/distroless/cc-debian12

# # COPY --from=BUILDER /usr/src/rust-github-webhook-reciever/target/x86_64-unknown-linux-musl/release/rust-github-webhook-reciever /usr/local/bin/
# COPY --from=BUILDER /usr/local/cargo/bin/rust-github-webhook-reciever /usr/local/bin/rust-github-webhook-reciever

# # COPY --from=BUILDER /etc/passwd /etc/passwd
# # COPY --from=BUILDER /etc/group /etc/group

# # USER user

# EXPOSE 8000

# ENTRYPOINT ["rust-github-webhook-reciever"]


# FROM alpine:latest

# ARG APP=/usr/src/app

# EXPOSE 8000

# ENV TZ=Etc/UTC \
#     APP_USER=appuser

# RUN addgroup -S $APP_USER \
#     && adduser -S -g $APP_USER $APP_USER

# RUN apk update \
#     && apk add --no-cache ca-certificates tzdata \
#     && rm -rf /var/cache/apk/*

# COPY --from=BUILDER /usr/local/cargo/bin/rust-github-webhook-reciever /usr/local/bin/rust-github-webhook-reciever

# RUN chown -R $APP_USER:$APP_USER /usr/local/bin/rust-github-webhook-reciever

# USER $APP_USER
# WORKDIR ${APP}

# ENTRYPOINT ["rust-github-webhook-reciever"]

FROM gcr.io/distroless/cc-debian12

COPY --from=BUILDER /usr/local/cargo/bin/rust-github-webhook-reciever /usr/local/bin/rust-github-webhook-reciever

EXPOSE 8000

ENTRYPOINT ["rust-github-webhook-reciever"]

