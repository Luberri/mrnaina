<!-- filepath: d:\S4\optim-Aina\mrnaina\naina\src\main\webapp\WEB-INF\views\reservation_form.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Nouvelle réservation</h2>
<form action="${pageContext.request.contextPath}/reservations/nouveau" method="post" autocomplete="off">
    <div style="position:relative;">
        <label>Adhérent :</label>
        <input id="adherentNom" type="text" name="adherentNom" required placeholder="Tapez le nom...">
        <input type="hidden" name="adherentId" id="adherentId">
        <div id="adherent-autocomplete-list" class="autocomplete-items"></div>
    </div>
    <br>
    <label for="livreId">Livre :</label>
    <select name="livreId" id="livreId" required>
        <c:forEach var="livre" items="${livres}">
            <option value="${livre.id}" <c:if test="${param.livreId == livre.id}">selected</c:if>>
                ${livre.titre}
            </option>
        </c:forEach>
    </select>
    <br>
    <button type="submit">Réserver</button>
</form>

<script>
    // Prépare la liste des adhérents côté JS
    var adherents = [
        <c:forEach var="adherent" items="${adherents}" varStatus="loop">
            {id: "${adherent.id}", nom: "${adherent.nom}"}<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
    ];

    const input = document.getElementById('adherentNom');
    const hiddenId = document.getElementById('adherentId');
    const autocompleteList = document.getElementById('adherent-autocomplete-list');

    input.addEventListener('input', function() {
        const val = this.value.trim().toLowerCase();
        autocompleteList.innerHTML = '';
        hiddenId.value = '';
        if (!val) return;
        let count = 0;
        adherents.forEach(function(adherent) {
            if (adherent.nom.toLowerCase().startsWith(val) && count < 8) {
                const div = document.createElement('div');
                div.textContent = adherent.nom;
                div.onclick = function() {
                    input.value = adherent.nom;
                    hiddenId.value = adherent.id;
                    autocompleteList.innerHTML = '';
                };
                autocompleteList.appendChild(div);
                count++;
            }
        });
    });

    document.addEventListener('click', function(e) {
        if (e.target !== input) autocompleteList.innerHTML = '';
    });
</script>