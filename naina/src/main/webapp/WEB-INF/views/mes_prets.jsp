<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    com.bibliotheque.naina.model.Adherent adherent = (com.bibliotheque.naina.model.Adherent) session.getAttribute("adherent");
%>
<h2>Mes prêts en cours</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Livre</th>
        <th>Date retour prévue</th>
        <th>Mode</th>
        <th>Action</th>
    </tr>
    <c:forEach var="pret" items="${prets}">
        <c:if test="${pret.adherent.id == adherent.id && !pret.rendu}">
            <tr>
                <td>${pret.id}</td>
                <td>${pret.exemplaire.livre.titre}</td>
                <td>${pret.dateRetour}</td>
                <td>${pret.mode.nom}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/prets/${pret.id}/rendre" method="post" style="display:inline;">
                        <button type="submit" class="btn">Rendre</button>
                    </form>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</table>