<%@ page import="java.sql.Connection" %>
<%@ page import="connexion.ManagerDBB" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: pierr_000
  Date: 29/12/2017
  Time: 16:23
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
<html lang="fr" xmlns="http://www.w3.org/1999/html">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Technicien | Charges</title>
    <!--  CSS  Bouton -->
    <link href="../../dist/css/bouton.css" rel="stylesheet">

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


    <!--<link href="../../vendor/bootstrap/css/bootstrap.css" rel="stylesheet">-->
    <link rel="stylesheet" href="../../dist/css/jquery.treegrid.css">

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






<div id="page" style="margin-left: 1%" style="margin-right: 1%">
    <div class="row" style="margin-top: 15px "> </div>
    <div class ="row" style="margin-left: 2%" >
        <div class="col-lg-2">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <p>Charges</p>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <table class="tree">
                            <%
                                try{
                                    System.out.println("conn = "+conn.isClosed());
                                    if(conn !=null && conn.isClosed()){
                                        response.sendError(500, "Exception sur l'accès à la BDD ");
                                    }else {
                                        Statement stmt = conn.createStatement();
                                        String requete = "SELECT idboitier, nom \n" +
                                                "\tFROM captainbdd.boitierprimaire \n" +
                                                "    WHERE boitierprimaire.idboitier IS NOT NULL\n" +
                                                "    ORDER BY idboitier;";
                                        ResultSet requestResult = stmt.executeQuery(requete);
                                        System.out.print(requestResult);
                                        if (requestResult != null) {

                                            while (requestResult.next()) {
                                                String idboitierprimaire = requestResult.getString(1);
                                                String boitier = requestResult.getString(2);
                            %>
                                               <tr class="treegrid-1">
                                                    <td> <%out.print(boitier);%></td>
                                                </tr>
                            <%
                                                String requete1 = String.format("SELECT nom \n" +
                                                        "\tFROM captainbdd.boitiersecondaire \n" +
                                                        "    WHERE boitierprimaire.idboitier= '%s' AND idboitiersec IS NOT NULL \n" +
                                                        "    ORDER BY idboitiersec;",idboitierprimaire);
                                                ResultSet requestResult1 = stmt.executeQuery(requete1);
                                                if (requestResult1 != null) {
                                                    while (requestResult1.next()) {
                                                        String nomboitiersecondaire = requestResult1.getString(1);
                            %>
                                                        <tr class="treegrid-2 treegrid-parent-1">
                                                            <td><%out.print(nomboitiersecondaire);%></td>
                                                        </tr>
                            <%
                                                     }

                                                }
                                            }
                                        }
                                    }
                                }catch(Exception e){
                                    e.printStackTrace();
                                }
                            %>
                            <tr class="treegrid-3 treegrid-parent-2">
                                <td>
                                    <ul>
                                        <li><a  href="#" onclick="openOption(event, 'charge')">Charge</a>
                                            <input class="switch" name="charge" id="chargeswitch" onchange="switchify()" type="checkbox" checked >
                                            <label for="charge" class="ui-content" >
                                                <div class="ui-switch-range">
                                                    <div class="ui-switch-handle"></div>
                                                </div>
                                            </label></li>
                                        <li><a  href="#" onclick="openOption(event, 'Lumière')">Lumière</a></li>
                                        <li><a  href="#" onclick="openOption(event, 'charge3')">Charge3</a></li>
                                    </ul>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3" style="margin-left: 2%", style="display: none" >
            <div class="row">
                <div class="panel panel-info" style="display: none" id="charge">
                    <div class="panel-heading ">Charges
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" onclick="closeOption(event, 'charge')">×</a>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                                <div class="form-group">
                                    <h1>charge</h1>
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label">Etat</label>
                                    <input type="text" class="form-control" id="etat">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Consommation</label>
                                    <input type="text" class="form-control" id="consommation">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Groupe</label>
                                    <input type="text" class="form-control" id="groupe">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Catégorie</label>
                                    <input type="text" class="form-control" id="categorie">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Dijoncteur concerné</label>
                                    <input type="text" class="form-control" id="Dijoncteur">
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <div class="panel panel-info" style="display: none;" id="Lumière">
                    <div class="panel-heading ">Charges
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" onclick="closeOption(event, 'Lumière')">×</a>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                                <div class="form-group">
                                    <h1>Lumière</h1>
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label">Etat</label>
                                    <input type="text" class="form-control" id="etatLumière">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Consommation</label>
                                    <input type="text" class="form-control" id="consommationLumière">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Groupe</label>
                                    <input type="text" class="form-control" id="groupeLumière">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Catégorie</label>
                                    <input type="text" class="form-control" id="categorieLumière">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Dijoncteur concerné</label>
                                    <input type="text" class="form-control" id="DijoncteurLumière">
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <div class="panel panel-info" style="display: none;" id="charge3">
                    <div class="panel-heading ">Charges
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" onclick="closeOption(event, 'charge3')">×</a>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                                <div class="form-group">
                                    <h1>charge 3</h1>
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label">Etat</label>
                                    <input type="text" class="form-control" id="etatcharge3">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Consommation</label>
                                    <input type="text" class="form-control" id="consommationcharge3">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Groupe</label>
                                    <input type="text" class="form-control" id="groupecharge3">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Catégorie</label>
                                    <input type="text" class="form-control" id="categoriecharge3">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Dijoncteur concerné</label>
                                    <input type="text" class="form-control" id="Dijoncteurcharge3">
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-2">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <p>Dijoncteurs</p>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <table class="tree">
                            <tr class="treegrid-1">
                                <td> Dijoncteur Principal</td>
                            </tr>
                            <tr class="treegrid-2 treegrid-parent-1">
                                <td> Boitier primaire</td>
                            </tr>
                            <tr class="treegrid-3 treegrid-parent-2">
                                <td>
                                    <ul>
                                        <li><a href="#" onclick="openOption(event, 'premier')">Boitier secondaire n°1</a></li>
                                        <li><a href="#" onclick="openOption(event, 'second')">Boitier secondaire n°2</a></li>
                                        <li><a href="#" onclick="openOption(event, 'troisieme')">Boitier secondaire n°3</a></li>
                                    </ul>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3" style="margin-right: 2%", style="display: none" >
            <div class="row">
                <div class="panel panel-info" style="display: none" id="premier">
                    <div class="panel-heading ">Boitier secondaire n°1
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" onclick="closeOption(event, 'premier')">×</a>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                                <div class="form-group">
                                    <h1>Boitier secondaire n°1</h1>
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label">Etat</label>
                                    <input type="text" class="form-control" id="etatpremier">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Consommation</label>
                                    <input type="text" class="form-control" id="consommationpremier">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Groupe</label>
                                    <input type="text" class="form-control" id="groupepremier">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Catégorie</label>
                                    <input type="text" class="form-control" id="categoriepremier">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Dijoncteur concerné</label>
                                    <input type="text" class="form-control" id="Dijoncteurpremier">
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <div class="panel panel-info" style="display: none;" id="second">
                    <div class="panel-heading ">Boitier secondaire n°2
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" onclick="closeOption(event, 'second')">×</a>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                                <div class="form-group">
                                    <h1>Boitier secondaire n°2</h1>
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label">Etat</label>
                                    <input type="text" class="form-control" id="etatsecond">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Consommation</label>
                                    <input type="text" class="form-control" id="consommationsecond">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Groupe</label>
                                    <input type="text" class="form-control" id="groupesecond">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Catégorie</label>
                                    <input type="text" class="form-control" id="categoriesecond">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Dijoncteur concerné</label>
                                    <input type="text" class="form-control" id="Dijoncteursecond">
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                <div class="panel panel-info" style="display: none;" id="troisieme">
                    <div class="panel-heading ">Boitier secondaire n°3
                        <a href="#" class="close" data-dismiss="alert" aria-label="close" onclick="closeOption(event, 'troisieme')">×</a>
                    </div>
                    <div class="panel-body">
                        <form role="form">
                            <fieldset>
                                <div class="form-group">
                                    <h1>Boitier secondaire n°3</h1>
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label">Etat</label>
                                    <input type="text" class="form-control" id="etattroisieme">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Consommation</label>
                                    <input type="text" class="form-control" id="consommationtroisieme">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Groupe</label>
                                    <input type="text" class="form-control" id="groupetroisieme">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Catégorie</label>
                                    <input type="text" class="form-control" id="categorietroisieme">
                                </div>
                                <div class="form-group has-success">
                                    <label class="control-label" >Dijoncteur concerné</label>
                                    <input type="text" class="form-control" id="Dijoncteurtroisieme">
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

<!-- JTree -->
<script type="text/javascript" src="../../js/jquery.treegrid.js"></script>
<script type="text/javascript" src="../../js/jquery.treegrid.bootstrap3.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('.tree').treegrid({
            expanderExpandedClass: 'glyphicon glyphicon-minus',
            expanderCollapsedClass: 'glyphicon glyphicon-plus'
        });
    });

    function openOption(evt, optionName) {

        document.getElementById(optionName).style.display = "block";
        evt.currentTarget.className += " active";
    }
    function closeOption(evt, optionName) {
        document.getElementById(optionName).style.display = "none";
        evt.currentTarget.className += " active";
    }
</script>

<script>
    function openSideOption(evt, chargeName) {
        // Declare all variables
        var i, tabcontent, tablinks;
        // Get all elements with class="tabcontent" and hide them
        tabcontent = document.getElementsByClassName("tabvertcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        // Get all elements with class="tablinks" and remove the class "active"
        tablinks = document.getElementsByClassName("chargelink");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        // Show the current tab, and add an "active" class to the link that opened the tab
        document.getElementById(chargeName).style.display = "block";
        evt.currentTarget.className += " active";
    }
</script>
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
<script>
    $(function () {
        // 6 create an instance when the DOM is ready
        $('#jstree').jstree();
        // 7 bind to events triggered on the tree
        $('#jstree').on("changed.jstree", function (e, data) {
            console.log(data.selected);
        });
        // 8 interact with the tree - either way is OK
        $('button').on('click', function () {
            $('#jstree').jstree(true).select_node('child_node_1');
            $('#jstree').jstree('select_node', 'child_node_1');
            $.jstree.reference('#jstree').select_node('child_node_1');
        });
    });
</script>
</body>

</html>
