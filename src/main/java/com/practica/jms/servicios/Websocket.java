package com.practica.jms.servicios;

import com.practica.jms.main.Main;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketClose;
import org.eclipse.jetty.websocket.api.annotations.OnWebSocketConnect;
import org.eclipse.jetty.websocket.api.annotations.WebSocket;

import org.eclipse.jetty.websocket.api.Session;

@WebSocket
public class Websocket {

    @OnWebSocketConnect
    public void conectando(Session usuario) {
        System.out.println("Conectando Usuario: " + usuario.getLocalAddress().getAddress().toString());
        Main.usuariosConectados.add(usuario);
    }

    @OnWebSocketClose
    public void cerrandoConexion(Session usuario, int statusCode, String reason) {
        System.out.println("Desconectando el usuario: " + usuario.getLocalAddress().getAddress().toString());
        Main.usuariosConectados.remove(usuario);
    }
}
