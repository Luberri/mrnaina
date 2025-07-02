<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des adhérents</title>
</head>
<body>
    <h2>Liste des adhérents</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Rôle</th>
            <th>Date de naissance</th>
        </tr>
        <c:forEach var="adherent" items="${adherents}">
            <tr>
                <td>${adherent.id}</td>
                <td>${adherent.nom}</td>
                <td>${adherent.role.nom}</td>
                <td>${adherent.dateNaissance}</td>
            </tr>
        </c:forEach>
    </table>
    <a href="${pageContext.request.contextPath}/logout">Déconnexion</a>
</body>
</html>