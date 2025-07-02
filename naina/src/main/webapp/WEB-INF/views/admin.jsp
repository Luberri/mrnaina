<!-- filepath: src/main/webapp/WEB-INF/views/admin.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Administration</title>
</head>
<body>
    <h2>Espace Administration</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/abonnement/nouveau">Faire un abonnement</a></li>
        <li><a href="${pageContext.request.contextPath}/adherents">Liste des adhérents</a></li>
        <li><a href="${pageContext.request.contextPath}/adherents/nouveau">Ajouter un adhérent</a></li>
        <li><a href="${pageContext.request.contextPath}/abonnes-mois">Liste des abonnés ce mois</a></li>
        <li><a href="${pageContext.request.contextPath}/prets/nouveau">Nouveau prêt</a></li>
    </ul>
    <a href="${pageContext.request.contextPath}/logout">Déconnexion</a>
</body>
</html>