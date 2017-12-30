<%@ page import="java.sql.Connection" %>
<%@ page import="connexion.ManagerDBB" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: pierr_000
  Date: 30/12/2017
  Time: 10:24
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

    <title>Technicien | Categories</title>

    <!-- Bootstrap Core CSS -->
    <link href="../../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

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
            <li class="navbar-link">
                <a class="link" href="repair-dashboard.jsp"><i class="fa fa-dashboard"></i> Tableau de bord</a>
            </li>
            <li class="navbar-link">
                <a class="link"  href="Charges.jsp"><i class="fa fa-bolt"></i> Groupes de charges</a>
            </li>
            <li class="navbar-link">
                <a class="link"  href="Categories.jsp"><i class="fa fa-bolt"></i> Categories</a>
            </li>

        </ul>
    </nav>
</div>

<div class="col-lg-8" style="margin-left: 10%">
    <div class="panel panel-default">
        <div class="panel-heading">
            Catégories
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th></th>
                        <th>Noms</th>
                        <th>Consommation</th>
                        <th>Etats</th>

                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1</td>
                        <td>Mark</td>
                        <td></td>
                        <td>ON/OFF</td>

                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Jacob</td>
                        <td></td>
                        <td>ON/OFF</td>

                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Larry</td>
                        <td></td>
                        <td>ON/OFF</td>

                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- /.table-responsive -->
        </div>
        <div class="col-lg-8"></div>
        <div class="col-lg-8" style="margin-left: 10%">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Charges/Selection Categorie
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>Nom</th>
                                <th>Charge</th>
                                <th>Dijoncteur Concerné n°</th>
                                <th>Catégorie</th>
                                <th>Etats</th>
                                <th>Consommation</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>1</td>
                                <td>Mark</td>
                                <td></td>
                                <td>ON/OFF</td>

                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Jacob</td>
                                <td></td>
                                <td>ON/OFF</td>

                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Larry</td>
                                <td></td>
                                <td>ON/OFF</td>

                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.table-responsive -->
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
</body>
</html>
