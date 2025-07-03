<!-- filepath: d:\S4\optim-Aina\mrnaina\naina\src\main\webapp\WEB-INF\views\abonnement_nouveau.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nouvel abonnement</title>
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
    <h2>Faire un abonnement</h2>
    <form action="${pageContext.request.contextPath}/abonnement/nouveau" method="post" autocomplete="off">
        <div style="position:relative;">
            <label for="adherentNom">Adhérent :</label>
            <input id="adherentNom" type="text" name="adherentNom" class="form-control" required placeholder="Tapez le nom..." oninput="updatePrixByNom()">
            <input type="hidden" name="adherentId" id="adherentId">
            <div id="adherent-autocomplete-list" class="autocomplete-items"></div>
        </div>
        <span id="prixAbonnement" style="margin-left:20px;"></span>
        <button class="btn" type="submit">Valider</button>
    </form>
    <script>
        // Prépare la liste des adhérents côté JS
        var adherents = [
            <c:forEach var="adherent" items="${adherents}" varStatus="loop">
                {id: "${adherent.id}", nom: "${adherent.nom}", roleId: "${adherent.role.id}"}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];
        var prixParRole = {
            <c:forEach var="tarif" items="${abonnementTarifs}" varStatus="loop">
                "${tarif.role.id}": ${tarif.prix}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        };

        // Autocomplétion simple
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
                        updatePrixByNom();
                    };
                    autocompleteList.appendChild(div);
                    count++;
                }
            });
        });

        // Fermer la liste si on clique ailleurs
        document.addEventListener('click', function(e) {
            if (e.target !== input) autocompleteList.innerHTML = '';
        });

        // Met à jour le prix selon le nom choisi
        function updatePrixByNom() {
            const nom = input.value.trim().toLowerCase();
            const adherent = adherents.find(a => a.nom.toLowerCase() === nom);
            if (adherent) {
                hiddenId.value = adherent.id;
                var prix = prixParRole[adherent.roleId];
                document.getElementById('prixAbonnement').textContent = "pour " + prix + " €";
            } else {
                hiddenId.value = '';
                document.getElementById('prixAbonnement').textContent = "";
            }
        }
    </script>

    <p><a href="${pageContext.request.contextPath}/admin">Retour admin</a></p>
</body>
</html>