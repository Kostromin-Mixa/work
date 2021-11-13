FROM alpine:latest

ENV GUNICORN_PORT=8000
ENV GUNICORN_MODULE=server
ENV GUNICORN_CALLABLE=app
ENV GUNICORN_USER=gunicorn
ENV APP_PATH=/opt/app

RUN apk add --no-cache python3 \
    && python3 -m ensurepip \
    && pip3 install --upgrade pip gunicorn \
    && adduser -D -h $APP_PATH $GUNICORN_USER

ADD . $APP_PATH

USER $GUNICORN_USER
WORKDIR $APP_PATH
CMD ['gunicorn app.py']