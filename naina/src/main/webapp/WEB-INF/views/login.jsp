<!-- filepath: src/main/webapp/WEB-INF/views/login.jsp -->
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Connexion</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>
        <button class="btn" type="submit">Se connecter</button>
    </form>

    <p>
        <a href="${pageContext.request.contextPath}/login-admin">Connexion admin</a>
    </p>
</body>
</html>