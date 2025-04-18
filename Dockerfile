FROM nginx:alpine
WORKDIR /app/quartz
COPY ./public /usr/share/nginx/html
COPY ./nginx-quartz.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
