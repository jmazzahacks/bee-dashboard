FROM node:15.14-alpine AS build
ARG REACT_APP_BEE_HOST=http://localhost:1633
ENV REACT_APP_BEE_HOST=$REACT_APP_BEE_HOST
WORKDIR /src
COPY . .
RUN npm ci
RUN npm run build

FROM node:15.14-alpine AS final
RUN npm i -g serve
WORKDIR /app
COPY --from=build /src/build .
ENV BEE_DESKTOP_PORT=8080
EXPOSE ${BEE_DESKTOP_PORT}
ENTRYPOINT ["sh", "-c", "serve -l ${BEE_DESKTOP_PORT}"]
