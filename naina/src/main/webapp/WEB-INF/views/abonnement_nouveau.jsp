<!-- filepath: src/main/webapp/WEB-INF/views/abonnement_nouveau.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvel abonnement</title>
</head>
<body>
    <h2>Faire un abonnement</h2>
    <form action="${pageContext.request.contextPath}/abonnement/nouveau" method="post">
        <label for="adherentId">Adhérent :</label>
        <select name="adherentId" id="adherentId" required onchange="updatePrix()">
            <option value="">-- Sélectionner --</option>
            <c:forEach var="adherent" items="${adherents}">
                <option value="${adherent.id}" data-role="${adherent.role.id}">
                    ${adherent.nom}
                </option>
            </c:forEach>
        </select>
        <span id="prixAbonnement" style="margin-left:20px;"></span>
        <button type="submit">Valider</button>
    </form>
    <script>
        // Map roleId -> prix
        var prixParRole = {
            <c:forEach var="tarif" items="${abonnementTarifs}" varStatus="loop">
                "${tarif.role.id}": ${tarif.prix}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        };

        function updatePrix() {
            var select = document.getElementById('adherentId');
            var selectedOption = select.options[select.selectedIndex];
            var roleId = selectedOption.getAttribute('data-role');
            var prix = prixParRole[roleId];
            document.getElementById('prixAbonnement').textContent = roleId ? "pour " + prix + " €" : "";
        }
    </script>
    <c:if test="${not empty message}">
        <div style="color:green">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <p><a href="${pageContext.request.contextPath}/admin">Retour admin</a></p>
</body>
</html>