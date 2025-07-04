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
                    <c:if test="${pret.mode.id == 1 && !pret.rendu}">
                        <form action="${pageContext.request.contextPath}/prets/${pret.id}/prolonger" method="post" style="display:inline;">
                            <button class="btn" style="color: black;" type="submit" name="jours" value="1"
                                <c:if test="${pret.prolongementJour != null && prolongementRoles != null}">
                                    <c:forEach var="pr" items="${prolongementRoles}">
                                        <c:if test="${pr.role.id == pret.adherent.role.id && pret.prolongementJour >= pr.nombreJour}">disabled</c:if>
                                    </c:forEach>
                                </c:if>
                            >+1j</button>
                            <button class="btn" style="color: black;" type="submit" name="jours" value="5"
                                <c:if test="${pret.prolongementJour != null && prolongementRoles != null}">
                                    <c:forEach var="pr" items="${prolongementRoles}">
                                        <c:if test="${pr.role.id == pret.adherent.role.id && pret.prolongementJour + 5 > pr.nombreJour}">disabled</c:if>
                                    </c:forEach>
                                </c:if>
                            >+5j</button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</table>