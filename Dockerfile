FROM node:latest

EXPOSE 4000 5000

ENV DEPLOY_ENV="default"

RUN npm i -g prisma2

RUN mkdir -p /src/app

COPY start.sh /src/app/start.sh

RUN chmod +x /src/app/start.sh

ENTRYPOINT ["bash", "/src/app/start.sh"]