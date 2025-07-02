<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouveau prêt</title>
</head>
<body>
    <h2>Enregistrer un prêt</h2>
    <form action="${pageContext.request.contextPath}/prets/nouveau" method="post">
        <label>Adhérent :</label>
        <select name="adherentId" required>
            <c:forEach var="adherent" items="${adherents}">
                <option value="${adherent.id}">${adherent.nom}</option>
            </c:forEach>
        </select><br>
        <label>Exemplaire :</label>
        <select name="exemplaireId" required>
            <c:forEach var="ex" items="${exemplaires}">
                <option value="${ex.id}">${ex.livre.titre} (dispo: ${ex.nombreDispo})</option>
            </c:forEach>
        </select><br>
        <label>Mode :</label>
        <select name="modeId" required>
            <c:forEach var="mode" items="${modes}">
                <option value="${mode.id}">${mode.nom}</option>
            </c:forEach>
        </select><br>
        <label>Date retour :</label>
        <input type="date" name="dateRetour" required><br>
        <button type="submit">Valider</button>
    </form>
    <c:if test="${not empty message}">
        <div style="color:green">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <a href="${pageContext.request.contextPath}/prets">Retour à la liste des prêts</a>
</body>
</html>