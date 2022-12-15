FROM python:3.9-slim
     
RUN useradd --create-home -u 99 -g 100 bdfr

RUN mkdir /app
COPY ./app/wrapper.sh /app/wrapper.sh
RUN chown -R bdfr /app && chmod 777 /app/wrapper.sh

RUN mkdir /config
COPY default_config.cfg /app/default_config.cfg
COPY options.yaml.example /app/options.yaml.example
RUN chown -R bdfr /config && chmod -R 666 /config

RUN DEBIAN_FRONTEND=noninteractive apt update && \
     apt install -y tar git htop iftop vim tzdata rdfind symlinks detox
     
RUN pip3 install git+https://github.com/aliparlakci/bulk-downloader-for-reddit.git@development

USER bdfr
WORKDIR /config

VOLUME /config
VOLUME /downloads

EXPOSE 7634

ENTRYPOINT ["/bin/bash"]
CMD ["/app/wrapper.sh"]
