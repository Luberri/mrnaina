<!-- filepath: naina/src/main/webapp/WEB-INF/views/reservation_form.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Nouvelle réservation</h2>
<form action="${pageContext.request.contextPath}/reservations/nouveau" method="post">
    <label for="adherentId">Adhérent :</label>
    <select name="adherentId" id="adherentId" required>
        <c:forEach var="adherent" items="${adherents}">
            <option value="${adherent.id}">${adherent.nom}</option>
        </c:forEach>
    </select>
    <br>
    <label for="livreId">Livre :</label>
    <select name="livreId" id="livreId" required>
        <c:forEach var="livre" items="${livres}">
            <option value="${livre.id}">${livre.titre}</option>
        </c:forEach>
    </select>
    <br>
    <button type="submit">Réserver</button>
</form>
<c:if test="${not empty message}">
    <div class="alert-success">${message}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert-error">${error}</div>
</c:if>