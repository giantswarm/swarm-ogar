FROM google/nodejs

WORKDIR /Ogar

RUN apt-get install git -y
RUN git clone git://github.com/forairan/Ogar.git Ogar

RUN npm install ./Ogar
RUN npm install ws

EXPOSE 443

ENTRYPOINT ["/nodejs/bin/node", "Ogar", "--master", "--game"] 
