FROM python:3.9-slim

RUN DEBIAN_FRONTEND=noninteractive apt update && \
     apt install -y tar git htop iftop vim tzdata rdfind symlinks detox

RUN pip3 install git+https://github.com/aliparlakci/bulk-downloader-for-reddit.git@development

RUN mkdir /app
COPY ./app/wrapper.sh /app/wrapper.sh
RUN chmod 777 /app/wrapper.sh

RUN mkdir /config
COPY default_config.cfg /app/default_config.cfg
COPY options.yaml.example /app/options.yaml.example

WORKDIR /config

VOLUME /config
VOLUME /downloads

EXPOSE 7634

RUN chown nobody /config /downloads /app

USER nobody
ENTRYPOINT ["/bin/bash"]
CMD ["/app/wrapper.sh"]
