FROM node:16-alpine

WORKDIR /app

COPY ./React-Springboot-App/frontend/package.json /app/package.json
RUN npm install

COPY ./React-Springboot-App/frontend /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# USER appuser

CMD ["npm", "start"]