<!-- filepath: src/main/webapp/WEB-INF/views/adherent_nouveau.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvel adhérent</title>
</head>
<body>
    <h2>Ajouter un adhérent</h2>
    <form action="${pageContext.request.contextPath}/adherents/nouveau" method="post">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>
        <br>
        <label for="roleId">Rôle :</label>
        <select name="roleId" id="roleId" required>
            <c:forEach var="role" items="${roles}">
                <option value="${role.id}">${role.nom}</option>
            </c:forEach>
        </select>
        <br>
        <label for="dateNaissance">Date de naissance :</label>
        <input type="date" id="dateNaissance" name="dateNaissance" required>
        <br>
        <button type="submit">Ajouter</button>
    </form>
    <p><a href="${pageContext.request.contextPath}/adherents">Retour à la liste</a></p>
</body>
</html>