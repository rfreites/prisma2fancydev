FROM node:latest

EXPOSE 4000 5555

ENV DEPLOY_ENV="default"

RUN npm i -g prisma2

RUN prisma2 lift

RUN mkdir -p /src/app

COPY start.sh /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["bash", "/start.sh"]