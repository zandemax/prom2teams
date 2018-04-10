FROM python:3.6-slim-stretch

LABEL maintainer="labs@idealista.com"

EXPOSE 8089

RUN apt-get update && apt-get install -y build-essential

COPY . /opt/prom2teams/
WORKDIR /opt/prom2teams

RUN mv dockerhub/config.ini ./config.ini
RUN mv dockerhub/prom2teams_start.sh ./prom2teams_start.sh
RUN mv dockerhub/replace_config.py ./replace_config.py
RUN rm -r dockerhub

RUN python3 setup.py install

ENV PROM2TEAMS_PORT="8089"
ENV PROM2TEAMS_HOST="0.0.0.0"
ENV PROM2TEAMS_LOGLEVEL="INFO"
ENV PROM2TEAMS_CONNECTOR=""

ENTRYPOINT ["bash", "/opt/prom2teams/prom2teams_start.sh"]
