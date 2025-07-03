<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Liste des réservations</h2>
<table border="1" style="width:100%;text-align:center;">
    <tr>
        <th>ID</th>
        <th>Adhérent</th>
        <th>Livre</th>
        <th>Date réservation</th>
        <th>Statut actuel</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="reservation" items="${reservations}">
        <tr>
            <td>${reservation.id}</td>
            <td>${reservation.adherent.nom}</td>
            <td>${reservation.livre.titre}</td>
            <td>${reservation.dateReservation}</td>
            <td>
                <c:set var="statuts" value="${reservationStatusService.findByReservationId(reservation.id)}"/>
                <c:choose>
                    <c:when test="${not empty statuts}">
                        <c:set var="dernierStatut" value="${statuts[0]}" />
                        <c:forEach var="s" items="${statuts}">
                            <c:if test="${s.id > dernierStatut.id}">
                                <c:set var="dernierStatut" value="${s}" />
                            </c:if>
                        </c:forEach>
                        ${dernierStatut.etat}
                    </c:when>
                    <c:otherwise>
                        en attente
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:set var="statuts" value="${reservationStatusService.findByReservationId(reservation.id)}"/>
                <c:choose>
                    <c:when test="${not empty statuts}">
                        <c:set var="dernierStatut" value="${statuts[0]}" />
                        <c:forEach var="s" items="${statuts}">
                            <c:if test="${s.id > dernierStatut.id}">
                                <c:set var="dernierStatut" value="${s}" />
                            </c:if>
                        </c:forEach>
                        <form action="${pageContext.request.contextPath}/reservations/${reservation.id}/statut" method="post" style="display:inline;">
                            <button class="btn" style="background-color: green; color: black;" type="submit" name="action" value="accepter"
                                <c:if test="${dernierStatut.etat == 'confirmee' || dernierStatut.etat == 'annulee'}">disabled</c:if>>
                                Acc
                            </button>
                        </form>
                        <form action="${pageContext.request.contextPath}/reservations/${reservation.id}/statut" method="post" style="display:inline;">
                            <button class="btn" style="background-color: red; color: black;" type="submit" name="action" value="refuser"
                                <c:if test="${dernierStatut.etat == 'confirmee' || dernierStatut.etat == 'annulee'}">disabled</c:if>>
                                Ref
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/reservations/${reservation.id}/statut" method="post" style="display:inline;">
                            <button class="btn" style="background-color: green; color: black;" type="submit" name="action" value="accepter">Accepter</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/reservations/${reservation.id}/statut" method="post" style="display:inline;">
                            <button class="btn" style="background-color: red; color: black;" type="submit" name="action" value="refuser">Refuser</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>