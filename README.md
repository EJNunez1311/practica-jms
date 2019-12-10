# practica13

Una empresa especialista en el desarrollo de sensores electrónicos para la toma de
temperatura y humedad, requiere de nuestros servicios para comunicar de forma
eficiente cada dispositivo final (EndPoint) con el servidor y dicha información pueda ser
visualizada en una aplicación web. Cada Endpoint implementa una trama JSON con la
siguiente estructura:

## Tabla Estructura JSON 




|         Campo          |             Tipo            |
|:----------------------:|:---------------------------:|
| fechaGeneración  | String formato DD/MM/YYYY HH:mm:ss |
|     IdDispositivo      |             Int             |
|      temperatura       |            Number           |
|        humedad         |            Number           |





Para enviar la información entre los dispositivos se estará utilizando un servidor que
implemente el estándar JMS y algún protocolo orientado a mensaje (OpenWire, MQTT,
AMQP) utilizando una cola del tipo de publicación/subscripción, llamada
notificacion_sensores. Cada dispositivo procesa información cada minuto y la envía a la
cola de distribución, el servidor toma el mensaje y lo persiste en la base de datos. Una
aplicación debe graficar en tiempo real la información que es recibida. Dado el siguiente
planteamiento y escenario realice:
1. Desarrolle un cliente que simule los Endpoint, que generen de forma aleatoria
valores de temperatura y humedad y envíe la trama en el formato JSON definido a
la cola indicada. Debe instanciar dos clientes para la prueba.
2. Implemente un servidor que soporte JMS y algún protocolo orientado a mensaje
que inicialice la cola de distribución del tipo publicación/subscripción. Puede ser
una aplicación con el protocolo de forma embebida o una servidor diseñado para
esos fines (Apache ActiveMQ, RabbitMQ, Mosquitto, entre otros).
3. Realicen una aplicación web que visualice los datos procesados mediantes gráficos
del tipo linea en tiempo real, donde se visualice la información de la temperatura y
la humedad vs el tiempo (separar los gráficos), para cada uno de los sensores
conectados. La comunicación entre la aplicación web y cliente puede ser utilizando
el protocolo HTTP o WebSocket.
