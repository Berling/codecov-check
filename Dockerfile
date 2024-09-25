FROM ubuntu:latest

RUN apt update && apt install -y curl jq bc

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
