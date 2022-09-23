FROM node:alpine as builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

# dockerfile을 찾을 수 없어서 -f라는 옵션을 주고 도커파일의 이름을 명시한다.
# docker build -f Dockerfile.dev .
# docker run -d -p 3000:3000 fada2020/react-app:latest
# docker run -d -p 3000:3000 -v /usr/src/app/node_modules -v %cd%:/usr/src/app fada2020/react-app:latest
# docker run -it -p 3000:3000 -v /usr/src/app/node_modules -v %cd%:/usr/src/app fada2020/react-app:latest
# docker run -it fada2020/react-app:latest npm run test
# nginx를 위한 베이스 이미지
FROM nginx 
# 다은 승테이지에 있는 파일을 복사할 때 다른 스테이지 이름을 명시
# 빌터 스테이지에서 생성된 파일들은 빌드에 들어가게 되며 그곳에 저장된 파일들을 html 밑으로 복사를 해서 nginx가 웹 브라우저의 http 요청이 올때마다
# 알맞는 파일을 전해 줄 수 있다.
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
# https://app.travis-ci.com/ 가입  