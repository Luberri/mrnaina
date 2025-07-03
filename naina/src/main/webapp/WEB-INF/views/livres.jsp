<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>Liste des livres</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .cards-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 20px;
            width: 300px;
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card h3 {
            margin-top: 0;
            color: #444;
        }
        .card p {
            margin: 5px 0;
        }
        .categories {
            margin-top: 10px;
        }
        .category {
            display: inline-block;
            background-color: #e0e0e0;
            color: #333;
            padding: 5px 10px;
            border-radius: 15px;
            margin: 3px;
            font-size: 0.85em;
        }
        .logout {
            display: block;
            text-align: center;
            margin-top: 30px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .logout:hover {
            text-decoration: underline;
        }
        .reserve-button {
            background: #00a8ff;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            display: inline-block;
            text-align: center;
            width: 100%;
        }
    </style>
</head>
<body>
    <h2>Liste des livres</h2>
    <div class="cards-container">
        <c:forEach var="livre" items="${livres}">
            <div class="card">
                <h3>${livre.titre}</h3>
                <p><strong>Auteur :</strong> ${livre.auteur}</p>
                <div class="categories">
                    <strong>Catégories :</strong>
                    <c:forEach var="cat" items="${livreCategories[livre.id]}">
                        <span class="category">${cat}</span>
                    </c:forEach>
                </div>
                <p>
                    <strong>Exemplaires disponibles :</strong>
                    <c:out value="${exemplairesDisponibles[livre.id]}" />
                </p>
                <form action="${pageContext.request.contextPath}/reservations/nouveau" method="get">
                    <input type="hidden" name="livreId" value="${livre.id}" />
                    <button type="submit" class="reserve-button">
                        Réserver
                    </button>
                </form>
            </div>
        </c:forEach>
    </div>
    <a class="logout" href="${pageContext.request.contextPath}/logout">Déconnexion</a>
</body>
</html>
