FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN apt install bash curl file git python3 python3-dev python3-pip unzip xz-utils zip -y

RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"
RUN flutter doctor

COPY . .
EXPOSE 8080
RUN flutter build web --release 
WORKDIR /home/developer/build/web
CMD python3 -m http.server 8080
