#Desde imagen base
FROM alpine:3.10

RUN apk add --no-cache curl jq

COPY test.sh .

#Existen los entry-point que definen que proceso va ejecutar la imagen
CMD [ "sh", "./test.sh" ]