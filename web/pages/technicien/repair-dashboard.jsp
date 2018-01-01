<%@ page import="java.sql.Connection" %>
<%@ page import="connexion.ManagerDBB" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Objects" %>
<%--
  Created by IntelliJ IDEA.
  User: pierr_000
  Date: 30/12/2017
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private ManagerDBB connexionDBB;
    private Connection conn;
%><%
    try {
        connexionDBB  = new ManagerDBB();
        conn = connexionDBB.connexion();
    }catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="fr">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Technicien | Tableau de bord</title>

    <!-- Bootstrap Core CSS -->
    <link href="../../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../vendor/bootstrap/css/bootstrap2-toggle.min.css" rel="stylesheet">


    <!-- MetisMenu CSS -->
    <link href="../../vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../../dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="../../vendor/morrisjs/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<div id="wrapper">

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header navbar-left">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="repair-dashboard.html">Captain</a>

        </div>
        <div class ="navbar-right">
            <a class="logout" href="login.html"><i class="fa fa-sign-out fa-fw"></i>Déconnexion</a>
            <img src="../../ressource/logo_edison_ways.png" style="margin-right: 20px" height="50">
        </div>
        <!-- /.navbar-header -->

        <ul class="nav navbar-top-links navbar-left">
            <li class="navbar-link active ">
                <a class="link " href="repair-dashboard.jsp"><i class="fa fa-dashboard"></i> Tableau de bord</a>
            </li>
            <li class="navbar-link">
                <a class="link"  href="Charges.jsp"><i class="fa fa-bolt"></i> Groupes de charges</a>
            </li>
            <li class="navbar-link">
                <a class="link"  href="Categories.jsp"><i class="fa fa-bolt"></i> Categories</a>
            </li>

        </ul>
    </nav>







    <div id="page" style="margin-left: 1%; margin-right: 1%" >

        <div class="row" style="margin-top: 15px" > </div>
        <div class="row">
            <div class="col-lg-7">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Résumé de la consomation
                    </div>
                    <div class="panel-body">

                        <div class="flot-chart">
                            <div class="flot-chart-content" id="flot-line-chart-moving"></div>
                        </div>
                        <div class ="row">
                            <div class="col-lg-6">
                                <p>Votre consomation : </p>
                            </div>
                            <div class="col-lg-6"> - - - </div>
                        </div>
                        <div class ="row">
                            <div class="col-lg-3">Consommation annuelle : </div>
                            <div class="col-lg-1"> - - - </div>
                            <div class ="col-lg-2">KWh</div>
                        </div>
                        <div class="row">
                            <div class="col-lg-5">Groupe de charge qui consomme le plus : </div>
                            <div class="col-lg-3"> - - -</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Groupes de Charges
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>Noms</th>
                                    <th>Etats</th>

                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    try{
                                        System.out.println("conn = "+conn.isClosed());
                                        if(conn !=null && conn.isClosed()){
                                            response.sendError(500, "Exception sur l'accès à la BDD ");
                                        }else {
                                            Statement stmt = conn.createStatement();
                                            String requete = "SELECT idgroupecharge,nom,etat FROM captainbdd.groupecharge WHERE groupecharge.idgroupecharge IS NOT NULL GROUP BY idgroupecharge" ;
                                            ResultSet requestResult = stmt.executeQuery(requete);
                                            if (requestResult != null) {
                                                while(requestResult.next()) {
                                                    String idgroupecharge = requestResult.getString(1);
                                                    String nomgroupecharge = requestResult.getString(2);
                                                    String etatgroupecharge = requestResult.getString(3);
                                %>
                                <tr>
                                    <td><%out.print(idgroupecharge);%></td>
                                    <td><%out.print(nomgroupecharge);%></td>
                                    <td>
                                        <%if(etatgroupecharge.equals("allume")){
                                            System.out.println("allume");%>
                                        <label>
                                            <input checked data-toggle="toggle" data-width="50" data-height="30" data-onstyle="success" data-offstyle="danger" type="checkbox" disabled>
                                        </label>
                                        <%}
                                            if(etatgroupecharge.equals("eteint")){
                                                System.out.println("eteint");%>
                                        <label>
                                            <input data-toggle="toggle" data-width="50" data-height="30" data-onstyle="success" data-offstyle="danger" type="checkbox" disabled>
                                        </label>
                                        <%}%>
                                    </td>
                                        <%
                                                }

                                            }
                                        }
                                    }catch(Exception e1){
                                        e1.printStackTrace();
                                        }
                                %>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.table-responsive -->
                    </div>
                    <!-- /.panel-body -->
                </div>

            </div>
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Charges
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>Noms</th>
                                    <th>Etats</th>

                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    try{
                                        System.out.println("conn = "+conn.isClosed());
                                        if(conn !=null && conn.isClosed()){
                                            response.sendError(500, "Exception sur l'accès à la BDD ");
                                        }else {
                                            Statement stmt = conn.createStatement();
                                            String requete = "SELECT idcharge,nom,etat FROM captainbdd.charge WHERE charge.idcharge IS NOT NULL GROUP BY idcharge" ;
                                            ResultSet requestResult = stmt.executeQuery(requete);
                                            if (requestResult != null) {
                                                while(requestResult.next()) {
                                                    String idcharge = requestResult.getString(1);
                                                    String nomcharge = requestResult.getString(2);
                                                    String etatcharge = requestResult.getString(3);
                                %>
                                <tr>
                                    <td><%out.print(idcharge);%></td>
                                    <td><%out.print(nomcharge);%></td>
                                    <td>
                                        <%if(etatcharge.equals("allume")){
                                            System.out.println("allume");%>
                                        <label>
                                            <input checked data-toggle="toggle" data-width="50" data-height="30" data-onstyle="success" data-offstyle="danger" type="checkbox" disabled>
                                        </label>
                                        <%}
                                        if(etatcharge.equals("eteint")){
                                            System.out.println("eteint");%>
                                        <label>
                                            <input data-toggle="toggle" data-width="50" data-height="30" data-onstyle="success" data-offstyle="danger" type="checkbox" disabled>
                                        </label>
                                        <%}%>
                                    </td>
                                        <%
                                                }

                                            }
                                        }
                                    }catch(Exception e1){
                                        e1.printStackTrace();
                                        }
                                %>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.table-responsive -->
                    </div>

                </div>
            </div>

            <div class="row" style="margin-bottom: 100px"> </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="panel-transparent">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel-transparent">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="panel-transparent">
                    </div>
                </div>
            </div>
        </div>


        <div class="row" style="margin-top: 15px"> </div>
        <div class="row">
            <div class="col-lg-4">
                <div class="panel-transparent">
                </div>
            </div>
            <div class="col-lg-4">
                <div class="panel-transparent">
                    <a href="rapport.html" class="btn btn-lg btn-success btn-block">Exporter le rapport </a>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="panel-transparent">
                </div>
            </div>
        </div>
    </div>
</div>
<%
    try {
        connexionDBB.closeDBB();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<script src="../../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../../vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="../../vendor/bootstrap/js/bootstrap2-toggle.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../../vendor/metisMenu/metisMenu.min.js"></script>

<!-- Morris Charts JavaScript -->
<script src="../../vendor/raphael/raphael.min.js"></script>
<script src="../../vendor/morrisjs/morris.min.js"></script>
<script src="../../data/morris-data.js"></script>

<!-- Custom Theme JavaScript -->
<script src="../../dist/js/sb-admin-2.js"></script>


<script src="../../vendor/flot/jquery.flot.js"></script>
<script src="../../data/flot-data.js"></script>
<script>
    $.fn.extend({
        switchify: function(e){
            $(this).each(function(){
                $(this).hide().after('<label for="'+$(this).attr('id')+'" class="ui-content"><div class="ui-switch-range"><div class="ui-switch-handle"></div></div></label>');
            });
        },
        slide: function(e){
        }
    });
</script>

</body>

</html>
