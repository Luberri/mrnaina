<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouveau prêt</title>

</head>
<body>
    <h2>Enregistrer un prêt</h2>
    <form action="${pageContext.request.contextPath}/prets/nouveau" method="post" autocomplete="off">
        <div style="position:relative;">
            <label>Adhérent :</label>
            <input id="adherentNom" type="text" name="adherentNom" required placeholder="Tapez le nom...">
            <input type="hidden" name="adherentId" id="adherentId">
            <div id="adherent-autocomplete-list" class="autocomplete-items"></div>
        </div>
        <br>
        <div style="position:relative;">
            <label>Exemplaire :</label>
            <input id="exemplaireTitre" type="text" name="exemplaireTitre" required placeholder="Tapez le titre...">
            <input type="hidden" name="exemplaireId" id="exemplaireId">
            <div id="exemplaire-autocomplete-list" class="autocomplete-items"></div>
        </div>
        <br>
        <label>Mode :</label>
        <select name="modeId" required>
            <c:forEach var="mode" items="${modes}">
                <option value="${mode.id}">${mode.nom}</option>
            </c:forEach>
        </select><br>

        <label for="datePret">Date retour :</label>
        <input type="date" name="datePret" id="datePret"><br>

        <button class="btn" type="submit">Valider</button>
    </form>
    <script>
        // Adhérents
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

        // Exemplaires
        var exemplaires = [
            <c:forEach var="ex" items="${exemplaires}" varStatus="loop">
                {id: "${ex.id}", titre: "${ex.livre.titre}", dispo: "${disponibilites[ex.id]}"}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        const exInput = document.getElementById('exemplaireTitre');
        const exHiddenId = document.getElementById('exemplaireId');
        const exAutocompleteList = document.getElementById('exemplaire-autocomplete-list');

        exInput.addEventListener('input', function() {
            const val = this.value.trim().toLowerCase();
            exAutocompleteList.innerHTML = '';
            exHiddenId.value = '';
            if (!val) return;
            let count = 0;
            exemplaires.forEach(function(ex) {
                if (ex.titre.toLowerCase().includes(val) && count < 8) {
                    const div = document.createElement('div');
                    div.textContent = ex.titre + " (dispo: " + ex.dispo + ")";
                    div.onclick = function() {
                        exInput.value = ex.titre + " (dispo: " + ex.dispo + ")";
                        exHiddenId.value = ex.id;
                        exAutocompleteList.innerHTML = '';
                    };
                    exAutocompleteList.appendChild(div);
                    count++;
                }
            });
        });

        document.addEventListener('click', function(e) {
            if (e.target !== input) autocompleteList.innerHTML = '';
            if (e.target !== exInput) exAutocompleteList.innerHTML = '';
        });
    </script>

    <a href="${pageContext.request.contextPath}/prets">Retour à la liste des prêts</a>
</body>
</html>