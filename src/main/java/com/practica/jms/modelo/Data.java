package com.practica.jms.modelo;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;

public class Data {

    private int idDispositivo;
    private Long temperatura;
    private Long humedad;
    private String fecha;

    public Data() {
//         DD/MM/YYYY HH:mm:ss
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("DD/MM/YYYY HH:mm:ss");
        Date date = new Date();

        setIdDispositivo((int) (Math.random() * 200) + 1);
        setFecha(simpleDateFormat.format(date));
        setHumedad((long) (Math.random() * 100) + 1);
        setTemperatura((long) (Math.random() * 35) + 1);
    }

    public Data(int idDispositivo, Long temperatura, Long humedad, String fecha) {
        this.idDispositivo = idDispositivo;
        this.temperatura = temperatura;
        this.humedad = humedad;
        this.fecha = fecha;
    }

    public int getIdDispositivo() {
        return idDispositivo;
    }

    public void setIdDispositivo(int idDispositivo) {
        this.idDispositivo = idDispositivo;
    }

    public Long getTemperatura() {
        return temperatura;
    }

    public void setTemperatura(Long temperatura) {
        this.temperatura = temperatura;
    }

    public Long getHumedad() {
        return humedad;
    }

    public void setHumedad(Long humedad) {
        this.humedad = humedad;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
}
