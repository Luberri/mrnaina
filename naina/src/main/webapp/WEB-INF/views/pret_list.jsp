<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des prêts</title>
</head>
<body>
    <h2>Liste des prêts</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Adhérent</th>
            <th>Livre</th>
            <th>Mode</th>
            <th>Date retour</th>
            <th>Rendu</th>
        </tr>
        <c:forEach var="pret" items="${prets}">
            <tr>
                <td>${pret.id}</td>
                <td>${pret.adherent.nom}</td>
                <td>${pret.exemplaire.livre.titre}</td>
                <td>${pret.mode.nom}</td>
                <td>${pret.dateRetour}</td>
                <td><c:out value="${pret.rendu ? 'Oui' : 'Non'}"/></td>
            </tr>
        </c:forEach>
    </table>
    <a href="${pageContext.request.contextPath}/prets/nouveau">Nouveau prêt</a>
</body>
</html>