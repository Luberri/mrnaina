<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Bibliothèque Naina'}</title>
    <style>
        /* Réinitialisation et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f5f6fa;
            display: flex;
            min-height: 100vh;
            color: #2d3436;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background: linear-gradient(180deg, #2d3436 0%, #1e272e 100%);
            color: #dfe6e9;
            position: fixed;
            height: 100%;
            padding: 20px 15px;
            transition: width 0.3s ease;
        }
        .sidebar h2 {
            font-size: 1.6rem;
            text-align: center;
            margin-bottom: 30px;
            color: #ffffff;
            font-weight: 600;
        }
        .sidebar ul {
            list-style: none;
        }
        .sidebar ul li {
            margin-bottom: 10px;
        }
        .sidebar a {
            display: flex;
            align-items: center;
            color: #dfe6e9;
            text-decoration: none;
            padding: 12px 15px;
            font-size: 1.1rem;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        .sidebar a:hover {
            background-color: #00a8ff;
            color: #ffffff;
            transform: translateX(5px);
        }
        .sidebar a::before {
            content: '➤';
            margin-right: 10px;
            font-size: 0.9rem;
        }

        /* Sous-menu pour Abonnement */
        .dropdown-toggle::before {
            content: '▼';
            margin-right: 10px;
            font-size: 0.8rem;
            transition: transform 0.3s ease;
        }
        .dropdown-toggle.active::before {
            transform: rotate(180deg);
        }
        .dropdown-menu {
            display: none;
            list-style: none;
            padding-left: 30px;
            margin-top: 5px;
        }
        .dropdown-menu li a {
            font-size: 1rem;
            padding: 8px 15px;
            color: #b2bec3;
        }
        .dropdown-menu li a:hover {
            color: #ffffff;
            background-color: #3b4b5c;
        }
        .dropdown-menu.active {
            display: block;
            animation: slideDown 0.3s ease-in-out;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            width: calc(100% - 260px);
            padding: 30px;
        }
        .header {
            background: #2c3e50;
            color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
            margin-bottom: 30px;
        }
        .header h1 {
            font-size: 1.9rem;
            margin: 0;
            font-weight: 600;
        }
        .header p {
            font-size: 1rem;
            margin: 5px 0 0;
            opacity: 0.8;
        }

        /* Contenu principal */
        .content {
            background: #ffffff;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        /* Messages d'alerte */
        .alert-success, .alert-error {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            font-size: 1rem;
        }
        .alert-success {
            background-color: #d4f4e2;
            color: #1b5e20;
            border: 1px solid #81c784;
        }
        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ef9a9a;
        }

        /* Styles pour les formulaires (directement sur les éléments HTML) */
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #b2bec3;
            border-radius: 6px;
            font-size: 1rem;
            font-family: inherit;
            background-color: #ffffff;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #00a8ff;
            box-shadow: 0 0 5px rgba(0, 168, 255, 0.3);
        }
        input[type="submit"], input[type="button"], button {
            background-color: #00a8ff;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            font-family: inherit;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover, input[type="button"]:hover, button:hover {
            background-color: #0097e6;
        }
        label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            color: #2d3436;
        }
        .form-group {
            margin-bottom: 20px;
        }

        /* Tableaux */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #ffffff;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #dfe6e9;
        }
        th {
            background-color: #f1f3f5;
            font-weight: 600;
            color: #2d3436;
        }
        tr:hover {
            background-color: #f8f9fa;
        }

        /* Footer */
        footer {
            text-align: center;
            padding: 20px;
            color: #636e72;
            background-color: #f5f6fa;
            margin-top: 40px;
            font-size: 0.9rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }
            .main-content {
                margin-left: 200rika1    width: calc(100% - 200px);
            }
            .header h1 {
                font-size: 1.5rem;
            }
        }
        @media (max-width: 576px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            .dropdown-menu {
                padding-left: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Bibliothèque Naina</h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Accueil</a></li>
            <li>
                <a href="#" class="dropdown-toggle">Adhérents</a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/adherents">Liste</a></li>
                    <li><a href="${pageContext.request.contextPath}/adherents/nouveau">Ajouter</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="dropdown-toggle">Livres</a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/livres">Liste</a></li>
                    <li><a href="${pageContext.request.contextPath}/livres/nouveau">Ajouter</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="dropdown-toggle">Prêts</a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/prets">Liste</a></li>
                    <li><a href="${pageContext.request.contextPath}/prets/nouveau">Nouveau</a></li>
                </ul>
            </li>
            <li>
                <a href="#" class="dropdown-toggle">Abonnement</a>
                <ul class="dropdown-menu">
                    <li><a href="${pageContext.request.contextPath}/abonnement/nouveau">Nouveau</a></li>
                    <li><a href="${pageContext.request.contextPath}/abonnements">Liste</a></li>
                    <li><a href="${pageContext.request.contextPath}/abonnement/renouveler">Renouveler</a></li>
                </ul>
            </li>
            <li><a href="${pageContext.request.contextPath}/logout">Déconnexion</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Gestion de la Bibliothèque Naina</h1>
            <p>Solution moderne pour la gestion des livres, abonnements et prêts</p>
        </div>

        <div class="content">
            <!-- Messages -->
            <c:if test="${not empty message}">
                <div class="alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert-error">${error}</div>
            </c:if>

            <!-- Contenu dynamique -->
            <jsp:include page="${body}" />
        </div>

        <!-- Footer -->
        <footer>
            © 2025 Bibliothèque Naina — Projet universitaire
        </footer>
    </div>

    <!-- JavaScript pour le sous-menu -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
            dropdownToggles.forEach(function(toggle) {
                toggle.addEventListener('click', function (e) {
                    e.preventDefault();
                    // Ferme les autres menus
                    document.querySelectorAll('.dropdown-menu').forEach(function(menu) {
                        if (menu !== toggle.nextElementSibling) menu.classList.remove('active');
                    });
                    document.querySelectorAll('.dropdown-toggle').forEach(function(t) {
                        if (t !== toggle) t.classList.remove('active');
                    });
                    // Ouvre/ferme le menu cliqué
                    toggle.nextElementSibling.classList.toggle('active');
                    toggle.classList.toggle('active');
                });
            });
        });
    </script>
</body>
</html>