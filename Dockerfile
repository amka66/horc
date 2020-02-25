FROM swipl:8.0.3
LABEL maintainer="Amir Kantor <amir.kantor@gmail.com>"
COPY ./ /app/horc/
RUN mkdir /app/horc/var
RUN mkdir /app/horc/included
RUN mv /app/horc/src/horn/*.hn /app/horc/included/
RUN mv /app/horc/src/prolog/*-queries.pl /app/horc/included/
WORKDIR /app/horc/included
ENTRYPOINT ["bash", "/app/horc/src/bash/run.sh"]
