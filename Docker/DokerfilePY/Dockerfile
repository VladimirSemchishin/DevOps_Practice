
FROM ubuntu AS build
RUN apt-get -y update
RUN apt-get -y install python3

WORKDIR /

COPY helloworld.py /helloworld.py
RUN /bin/bash && python3 /helloworld.py > /index.html


FROM nginx:alpine AS output
COPY --from=build /index.html /usr/share/nginx/html

EXPOSE 80