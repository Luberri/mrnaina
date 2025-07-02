<!-- filepath: src/main/webapp/WEB-INF/views/login_admin.jsp -->
<!DOCTYPE html>
<html>
<head>
    <title>Login Admin</title>
</head>
<body>
    <h2>Connexion Admin</h2>
    <form action="${pageContext.request.contextPath}/login-admin" method="post">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>
        <br>
        <label for="mdp">Mot de passe :</label>
        <input type="password" id="mdp" name="mdp" required>
        <br>
        <button type="submit">Se connecter</button>
    </form>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <p>
        <a href="${pageContext.request.contextPath}/login">Retour utilisateur</a>
    </p>
</body>
</html>