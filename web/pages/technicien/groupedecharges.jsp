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
                <a class="link"  href="Charges.jsp"><i class="fa fa-bolt"></i> Charges</a>
            </li>
            <li class="navbar-link">
                <a class="link"  href="groupedecharges.jsp"><i class="fa fa-bolt"></i> Groupes de charges</a>
            </li>

        </ul>
    </nav>
</div>

<div class="col-lg-8" style="margin-left: 10%">
    <div class="panel panel-default">
        <div class="panel-heading">
            Groupes de charges
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
                    <%
                        try{
                            System.out.println("conn = "+conn.isClosed());
                            if(conn !=null && conn.isClosed()){
                                response.sendError(500, "Exception sur l'accès à la BDD ");
                            }else {
                                Statement stmt = conn.createStatement();
                                String requete = "SELECT idgroupecharge,nom,etat,consommation FROM captainbdd.groupecharge WHERE groupecharge.idgroupecharge IS NOT NULL GROUP BY idgroupecharge" ;
                                ResultSet requestResult = stmt.executeQuery(requete);
                                if (requestResult != null) {
                                    while(requestResult.next()) {
                                        String idgroupecharge = requestResult.getString(1);
                                        String nomgroupecharge = requestResult.getString(2);
                                        String etatgroupecharge = requestResult.getString(3);
                                        int consommationgroupecharge = requestResult.getInt(4);
                    %>
                    <tr>
                        <td><%out.print(idgroupecharge);%></td>
                        <td><%out.print(nomgroupecharge);%></td>
                        <td><%out.print(consommationgroupecharge);%></td>
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
    </div>
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
                                <th></th>
                                <th>Nom charge</th>
                                <th>Etat charge</th>
                                <th>Dijoncteur Concerné n°</th>
                                <th>Catégorie</th>
                                <th>priorité</th>
                                <th>Calibre</th>
                                <th>puissance</th>
                                <th>Consommation</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                try{
                                    System.out.println("conn = "+conn.isClosed());
                                    if(conn !=null && conn.isClosed()){
                                        response.sendError(500, "Exception sur l'accès à la BDD ");
                                    }else {
                                        Statement stmt1 = conn.createStatement();
                                        String requete = " SELECT charge.idcharge,  charge.nom, charge.etat, charge.calibre, charge.priorite, charge.puissance, charge.consommation, bs.nom AS Dijoncteur , categorie.nom AS Categorie\n" +
                                                "                            FROM captainbdd.charge AS charge, captainbdd.groupecharge_charge AS gc, captainbdd.categorie_charge AS cc, captainbdd.boitiersecondaire AS bs, captainbdd.categorie AS categorie\n" +
                                                "                            WHERE charge.idcharge IS NOT NULL AND gc.idcharge IS NOT NULL AND cc.idcharge IS NOT NULL AND cc.idcharge = charge.idcharge = gc.idcharge AND bs.idboitiersec = charge.idboitiersec AND categorie.idcategorie = cc.idcategorie\n" +
                                                "                            ORDER BY charge.idcharge;" ;
                                        ResultSet requestResult1 = stmt1.executeQuery(requete);
                                        if (requestResult1 != null) {
                                            while(requestResult1.next()) {
                                                String idcharge = requestResult1.getString(1);
                                                String nomcharge = requestResult1.getString(2);
                                                String etatcharge = requestResult1.getString(3);
                                                int calibrecharge = requestResult1.getInt(4);
                                                int prioritecharge = requestResult1.getInt(5);
                                                int puissancecharge = requestResult1.getInt(6);
                                                int consommationcharge = requestResult1.getInt(7);
                                                String dijoncteur = requestResult1.getString(8);
                                                String categorie = requestResult1.getString(9);
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
                                <td><%out.print(dijoncteur);%></td>
                                <td><%out.print(categorie);%></td>
                                <td><%out.print(prioritecharge);%></td>
                                <td><%out.print(calibrecharge);%></td>
                                <td><%out.print(puissancecharge);%></td>
                                <td><%out.print(consommationcharge);%></td>
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
