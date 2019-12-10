package com.practica.jms.main;

import com.practica.jms.modelo.Consumidor;
import com.practica.jms.servicios.Websocket;
import freemarker.template.Configuration;
import freemarker.template.Version;
import org.eclipse.jetty.websocket.api.annotations.WebSocket;
import spark.ModelAndView;
import spark.template.freemarker.FreeMarkerEngine;


import javax.jms.JMSException;

import org.eclipse.jetty.websocket.api.Session;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static spark.Spark.get;
import static spark.Spark.staticFiles;
import static spark.Spark.webSocket;

public class    Main {

    public static List<Session> usuariosConectados = new ArrayList<>();

    public static void main(String[] args) throws JMSException {

        staticFiles.location("/static");

        Configuration configuration = new Configuration(new Version(2, 3, 3));
        configuration.setClassForTemplateLoading(Main.class, "/templates");

        String cola = "notificaciones.cola";
        webSocket("/nuevoMensaje", Websocket.class);

        FreeMarkerEngine freeMarkerEngine = new FreeMarkerEngine(configuration);

        get("/", (req, res) -> {
            Map<String, Object> attributes = new HashMap<>();

            return new ModelAndView(attributes, "inicio.ftl");

        },freeMarkerEngine);


        Consumidor servicioConsumidor = new Consumidor(cola);
        servicioConsumidor.conectar();


    }

    public static void enviarMensaje(String mensaje) {
        for (Session sesionConectada : usuariosConectados) {
            try {
                sesionConectada.getRemote().sendString(mensaje);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
