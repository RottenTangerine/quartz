# Quartz v4

This repo is fork from [jackyzha0/quartz](https://github.com/jackyzha0/quartz)

我删除了大部分无关内容,并做了我自己的一些修改,目前这个仓库仅用来我用于将Obsidian Vault打包为静态的文件



## Dockerfile

在Obsidian Vault中添加Dockerfile直接部署

```dockerfile
FROM node:22-alpine AS builder

RUN apk add --no-cache coreutils git python3 make g++

WORKDIR /app
RUN git clone https://github.com/RottenTangerine/quartz.git && \
    cd quartz && \
    npm install
  
COPY . /app/quartz/content

WORKDIR /app/quartz
RUN npx quartz build
  
# 使用 Nginx 作为生产服务器  
FROM nginx:alpine
COPY --from=builder /app/quartz/public /usr/share/nginx/html
COPY --from=builder /app/quartz/nginx.conf /etc/nginx/conf.d/default.conf
  
EXPOSE 80
  
CMD ["nginx", "-g", "daemon off;"]
```