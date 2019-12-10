package com.practica.jms.main;

import com.practica.jms.modelo.Productor;
import org.apache.activemq.broker.BrokerService;

import javax.jms.JMSException;

public class GenerarMensajes {

    public static void main(String[] args) throws JMSException {
        String cola = " notificaciones.cola";

        BrokerService brokerService = new BrokerService();
        try {
            brokerService.addConnector("tcp://localhost:61616");
            brokerService.start();
        } catch (Exception e) {
            e.printStackTrace();
        }

        new Productor().enviarMensaje(cola);
    }
}
