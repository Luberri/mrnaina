<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouveau prêt</title>
    <style>
        .autocomplete-items {
            position: absolute;
            border: 1px solid #d4d4d4;
            border-bottom: none;
            border-top: none;
            z-index: 99;
            top: 100%;
            left: 0;
            right: 0;
            background: #fff;
        }
        .autocomplete-items div {
            padding: 10px;
            cursor: pointer;
            background-color: #fff;
            border-bottom: 1px solid #d4d4d4;
        }
        .autocomplete-items div:hover {
            background-color: #e9e9e9;
        }
        .autocomplete-active {
            background-color: #00a8ff !important;
            color: #fff;
        }
    </style>
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
        <label>Exemplaire :</label>
        <select name="exemplaireId" required>
            <c:forEach var="ex" items="${exemplaires}">
                <option value="${ex.id}">${ex.livre.titre} (dispo: ${ex.nombreDispo})</option>
            </c:forEach>
        </select><br>
        <label>Mode :</label>
        <select name="modeId" required>
            <c:forEach var="mode" items="${modes}">
                <option value="${mode.id}">${mode.nom}</option>
            </c:forEach>
        </select><br>
        <label>Date retour :</label>
        <input type="date" name="dateRetour" required><br>
        <button type="submit">Valider</button>
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
    <c:if test="${not empty message}">
        <div style="color:green">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div style="color:red">${error}</div>
    </c:if>
    <a href="${pageContext.request.contextPath}/prets">Retour à la liste des prêts</a>
</body>
</html>