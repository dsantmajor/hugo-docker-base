FROM alpine:latest as STAGEONE
RUN apk update && apk add hugo \
    && mkdir /site \
    && mkdir /site/themes \
    && git clone https://github.com/jeblister/kube.git /site/themes

COPY ./site /site
RUN hugo --source=/site/ --destination=/public/

FROM nginx:stable-alpine
COPY --from=STAGEONE /public/ /usr/share/nginx/html/
EXPOSE 80
