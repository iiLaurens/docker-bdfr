FROM python:3.9-slim
     
RUN useradd --no-create-home -u 99 -g 100 bdfr

RUN mkdir /app
COPY ./app/wrapper.sh /app/wrapper.sh
RUN chmod 777 /app/wrapper.sh

RUN mkdir /config
COPY default_config.cfg /app/default_config.cfg
COPY options.yaml.example /app/options.yaml.example

RUN DEBIAN_FRONTEND=noninteractive apt update && \
     apt install -y tar git htop iftop vim tzdata rdfind symlinks detox
     
RUN pip3 install git+https://github.com/aliparlakci/bulk-downloader-for-reddit.git@development

USER bdfr
WORKDIR /config
RUN chown -R bdfr /config && chmod -R 666 /config

VOLUME /config
VOLUME /downloads

EXPOSE 7634

ENTRYPOINT ["/bin/bash"]
CMD ["/app/wrapper.sh"]
