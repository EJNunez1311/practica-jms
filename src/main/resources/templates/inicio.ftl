<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../favicon.ico">

    <title>Dashboard Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/dashboard.css" rel="stylesheet">
</head>

<body>
<nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Zucca IT</a>
<#--<input class="form-control form-control-dark w-100" type="text" placeholder="Search" aria-label="Search">-->
    <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
        <#--<a class="nav-link" href="#">Sign out</a>-->
        </li>
    </ul>
</nav>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
            <div class="sidebar-sticky">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="/">
                            <span data-feather="home"></span>
                            Inicio <span class="sr-only">(current)</span>
                        </a>
                    </li>


                </ul>

            </div>
        </nav>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
                <h1 class="h2">Inicio</h1>
            <#--<div class="btn-toolbar mb-2 mb-md-0">-->
            <#--<div class="btn-group mr-2">-->
            <#--<button class="btn btn-sm btn-outline-secondary">Share</button>-->
            <#--<button class="btn btn-sm btn-outline-secondary">Export</button>-->
            <#--</div>-->
            <#--<button class="btn btn-sm btn-outline-secondary dropdown-toggle">-->
            <#--<span data-feather="calendar"></span>-->
            <#--This week-->
            <#--</button>-->
            <#--</div>-->
            </div>

            <canvas class="my-4" id="chart" width="900" height="380"></canvas>


            <br>
            <br>


            <canvas class="my-4" id="humedad" width="900" height="380"></canvas>


        </main>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="../static/js/bootstrap.min.js"></script>

<!-- Icons -->
<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
<script>
    feather.replace()
</script>

<!-- Graphs -->
<script src="/echarts.min.js"></script>
<script>

    let chartTemperatura, chartHumedad;
    let dataTemperatura = [], dataHumedad = [];
    let ejeXTemperatura = [], ejeXHumedad = [];
    let webSocket;
    let tiempoReconectar = 5000;

    $(document).ready(function () {

        3();

        grafico2();
    });

    function grafico1() {

        let option;
        option = {
            title: {
                text: 'Temperatura'
            },
            tooltip: {
                trigger: 'axis',
                // formatter: function (params) {
                //
                //     // console.log(params);
                //     return params[0].axisValue + ' ' + params[0].value[1];
                // }


            },
            xAxis: {
                type: 'category',
                data: ejeXTemperatura,
                splitLine: {
                    show: false
                }
            },
            yAxis: {
                type: 'value',
                boundaryGap: [0, '100%'],
                splitLine: {
                    show: false
                }
            },
            series: [{
                data: [0],
                type: 'line',
                hoverAnimation: false,
            }],
            color: ['rgb(29, 227, 9)'],


        };

        chartTemperatura = echarts.init(document.getElementById("chart"));
        chartTemperatura.setOption(option);

    }

    function grafico2() {

        let option;
        option = {
            title: {
                text: 'Humedad'
            },
            tooltip: {
                trigger: 'axis',


            },
            xAxis: {
                type: 'category',
                data: ejeXHumedad,
                splitLine: {
                    show: false
                }
            },
            yAxis: {
                type: 'value',
                boundaryGap: [0, '100%'],
                splitLine: {
                    show: false
                }
            },
            series: [{
                data: [0],
                type: 'line',
                hoverAnimation: false,
            }],
            color: ['rgb(8, 179, 238)'],


        };

        chartHumedad = echarts.init(document.getElementById("humedad"));
        chartHumedad.setOption(option);

    }

    function nuevoValor(datos) {

        let nuevo = JSON.parse(datos);
        // console.log(nuevo);
        // data.shift();
        dataTemperatura.push(nuevo.temperatura);
        dataHumedad.push(nuevo.humedad);

        // ejeX.shift();
        ejeXTemperatura.push(nuevo.fecha);
        ejeXHumedad.push(nuevo.fecha);

        chartTemperatura.setOption({
            xAxis: {
                data: ejeXTemperatura
            },

            series: [{
                data: dataTemperatura
            }]

        });

        chartHumedad.setOption({
            xAxis: {
                data: ejeXHumedad
            },

            series: [{
                data: dataHumedad
            }]

        });
    }


    function conectar() {
        webSocket = new WebSocket("ws://" + location.hostname + ":" + location.port + "/nuevoMensaje");
        webSocket.onmessage = function (datos) {
            // console.log(datos);
            nuevoValor(datos.data);
        };
    }

    function verificarConexion() {
        if (!webSocket || webSocket.readyState === 3) {
            conectar();
        }
    }

    setInterval(verificarConexion, tiempoReconectar);

</script>
</body>
</html>
