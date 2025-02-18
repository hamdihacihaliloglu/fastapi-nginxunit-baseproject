FROM python:3.11.6-alpine3.18

RUN apk update --no-cache && \
    apk add --no-cache unit-python3 curl tzdata gcc g++ libc-dev libffi-dev libpq-dev && \
    apk upgrade --no-cache

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --upgrade wheel setuptools requests

COPY ./app /code/app
COPY ./config/nginx/*.json /docker-entrypoint.d/
COPY ./config/entrypoint.sh /opt/entrypoint.sh

RUN chown -R unit:unit /code/app && \
    chmod +x /opt/entrypoint.sh &&\
    ln -sf /dev/stdout /var/log/unit.log

ENTRYPOINT ["/opt/entrypoint.sh"]
STOPSIGNAL SIGTERM
CMD ["unitd", "--no-daemon", "--control", "unix:/var/run/control.unit.sock"]