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

USER $GUNICORN_USER
WORKDIR $APP_PATH
ADD requirements.txt $APP_PATH/
RUN pip3 install -r requirements.txt

ADD entrypoint.sh $APP_PATH/
ADD *.py $APP_PATH/
RUN chmod +x entrypoint.sh
