#Desde imagen base
FROM ubuntu:18.04

#Cada RUN(Que ejecuta) hace un commit
RUN apt-get update && apt-get install -y curl jq && rm -rf /var/lib/apt/lists/*


COPY test.sh .

#Existen los entry-point que definen que proceso va ejecutar la imagen
ENTRYPOINT [ "./test.sh" ]