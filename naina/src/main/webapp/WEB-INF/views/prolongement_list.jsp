<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Demandes de prolongement</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Adhérent</th>
        <th>Livre</th>
        <th>Nombre de jours demandés</th>
        <th>Action</th>
    </tr>
    <c:forEach var="demande" items="${prolongements}">
        <tr>
            <td>${demande.id}</td>
            <td>${demande.pret.adherent.nom}</td>
            <td>${demande.pret.exemplaire.livre.titre}</td>
            <td>${demande.nombreJour}</td>
            <td>
                <form action="${pageContext.request.contextPath}/prolongements/${demande.id}/valider" method="post" style="display:inline;">
                    <button type="submit" class="btn">Acc</button>
                </form>
                <form action="${pageContext.request.contextPath}/prolongements/${demande.id}/refuser" method="post" style="display:inline;">
                    <button type="submit" class="btn">Ref</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>