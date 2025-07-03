<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    com.bibliotheque.naina.model.Adherent adherent = (com.bibliotheque.naina.model.Adherent) session.getAttribute("adherent");
    int maxResa = 0;
    if (adherent != null && request.getAttribute("reservationRoles") != null) {
        java.util.List reservationRoles = (java.util.List) request.getAttribute("reservationRoles");
        for (Object obj : reservationRoles) {
            com.bibliotheque.naina.model.ReservationRole rr = (com.bibliotheque.naina.model.ReservationRole) obj;
            if (rr.getRole().getId().equals(adherent.getRole().getId())) {
                maxResa = rr.getNombreLivreMax();
                break;
            }
        }
    }
    int nbEnCours = 0;
    java.util.List reservations = (java.util.List) request.getAttribute("reservations");
    com.bibliotheque.naina.service.ReservationStatusService reservationStatusService =
        (com.bibliotheque.naina.service.ReservationStatusService) request.getAttribute("reservationStatusService");
    if (adherent != null && reservations != null && reservationStatusService != null) {
        for (Object obj : reservations) {
            com.bibliotheque.naina.model.Reservation r = (com.bibliotheque.naina.model.Reservation) obj;
            if (r.getAdherent().getId().equals(adherent.getId())) {
                java.util.List statuts = reservationStatusService.findByReservationId(r.getId());
                com.bibliotheque.naina.model.ReservationStatus dernierStatut = null;
                for (Object sObj : statuts) {
                    com.bibliotheque.naina.model.ReservationStatus s = (com.bibliotheque.naina.model.ReservationStatus) sObj;
                    if (dernierStatut == null || s.getId() > dernierStatut.getId()) {
                        dernierStatut = s;
                    }
                }
                if (dernierStatut == null || "confirmee".equalsIgnoreCase(dernierStatut.getEtat())) {
                    nbEnCours++;
                }
            }
        }
    }
    int reste = maxResa - nbEnCours;
    int nbEnAttente = 0;
    if (adherent != null && reservations != null && reservationStatusService != null) {
        for (Object obj : reservations) {
            com.bibliotheque.naina.model.Reservation r = (com.bibliotheque.naina.model.Reservation) obj;
            if (r.getAdherent().getId().equals(adherent.getId())) {
                java.util.List statuts = reservationStatusService.findByReservationId(r.getId());
                com.bibliotheque.naina.model.ReservationStatus dernierStatut = null;
                for (Object sObj : statuts) {
                    com.bibliotheque.naina.model.ReservationStatus s = (com.bibliotheque.naina.model.ReservationStatus) sObj;
                    if (dernierStatut == null || s.getId() > dernierStatut.getId()) {
                        dernierStatut = s;
                    }
                }
                if (dernierStatut != null && "en attente".equalsIgnoreCase(dernierStatut.getEtat())) {
                    nbEnAttente++;
                }
            }
        }
    }
%>

<style>
    .reservations-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
    }

    .header-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 30px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    }

    .header-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin: 0 0 20px 0;
        text-align: center;
    }

    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }

    .stat-card {
        background: rgba(255,255,255,0.2);
        backdrop-filter: blur(10px);
        border-radius: 10px;
        padding: 20px;
        text-align: center;
        border: 1px solid rgba(255,255,255,0.3);
        transition: transform 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-5px);
    }

    .stat-number {
        font-size: 2rem;
        font-weight: bold;
        margin-bottom: 5px;
    }

    .stat-label {
        font-size: 0.9rem;
        opacity: 0.9;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .filter-section {
        background: white;
        padding: 25px;
        border-radius: 15px;
        margin-bottom: 30px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        border: 1px solid #e9ecef;
    }

    .filter-title {
        font-size: 1.3rem;
        font-weight: 600;
        margin-bottom: 20px;
        color: #495057;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .filter-title::before {
        content: "🔍";
        font-size: 1.2rem;
    }

    .filter-form {
        display: flex;
        gap: 15px;
        align-items: end;
        flex-wrap: wrap;
    }

    .input-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .input-group label {
        font-weight: 500;
        color: #6c757d;
        font-size: 0.9rem;
    }

    .date-input {
        padding: 12px 15px;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
        background: white;
    }

    .date-input:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    .btn-filter {
        padding: 12px 30px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
        letter-spacing: 1px;
        font-size: 0.9rem;
    }

    .btn-filter:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
    }

    .table-container {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        border: 1px solid #e9ecef;
    }

    .table-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px;
        font-size: 1.2rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .table-header::before {
        content: "📚";
        font-size: 1.3rem;
    }

    .reservations-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
    }

    .reservations-table th {
        background: #f8f9fa;
        padding: 15px;
        text-align: left;
        font-weight: 600;
        color: #495057;
        border-bottom: 2px solid #e9ecef;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-size: 0.8rem;
    }

    .reservations-table td {
        padding: 15px;
        border-bottom: 1px solid #e9ecef;
        color: #6c757d;
    }

    .reservations-table tbody tr {
        transition: background-color 0.3s ease;
    }

    .reservations-table tbody tr:hover {
        background-color: #f8f9fa;
    }

    .status-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
    }

    .status-confirmee {
        background: #d4edda;
        color: #155724;
    }

    .status-en-attente {
        background: #fff3cd;
        color: #856404;
    }

    .status-annulee {
        background: #f8d7da;
        color: #721c24;
    }

    .status-terminee {
        background: #d1ecf1;
        color: #0c5460;
    }

    .book-title {
        font-weight: 600;
        color: #495057;
    }

    .reservation-id {
        font-family: 'Courier New', monospace;
        background: #f8f9fa;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 0.85rem;
    }

    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #6c757d;
    }

    .empty-state::before {
        content: "📖";
        font-size: 3rem;
        display: block;
        margin-bottom: 20px;
    }

    .empty-state h3 {
        margin-bottom: 10px;
        color: #495057;
    }

    @media (max-width: 768px) {
        .reservations-container {
            padding: 15px;
        }
        
        .header-title {
            font-size: 2rem;
        }
        
        .filter-form {
            flex-direction: column;
            align-items: stretch;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .reservations-table {
            font-size: 0.85rem;
        }
        
        .reservations-table th,
        .reservations-table td {
            padding: 10px 8px;
        }
    }
</style>

<div class="reservations-container">
    <div class="header-section">
        <h1 class="header-title">Mes Réservations</h1>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number"><%= maxResa %></div>
                <div class="stat-label">Maximum autorisé</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= reste %></div>
                <div class="stat-label">Restantes</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= nbEnAttente %></div>
                <div class="stat-label">En attente</div>
            </div>
        </div>
    </div>

    <div class="filter-section">
        <form method="get" action="${pageContext.request.contextPath}/mes-reservations" class="filter-form">
            <div class="input-group">
                <label for="dateDebut">Date de début</label>
                <input type="date" id="dateDebut" name="dateDebut" value="${dateDebut}" class="date-input">
            </div>
            <div class="input-group">
                <label for="dateFin">Date de fin</label>
                <input type="date" id="dateFin" name="dateFin" value="${dateFin}" class="date-input">
            </div>
            <button type="submit" class="btn-filter">Filtrer</button>
        </form>
    </div>

    <div class="table-container">
        <div class="table-header">
            Liste des réservations
        </div>
        
        <c:set var="hasReservations" value="false" />
        <c:forEach var="reservation" items="${reservations}">
            <c:if test="${reservation.adherent.id == adherent.id
                && (empty dateDebut || reservation.dateReservation >= dateDebut)
                && (empty dateFin || reservation.dateReservation <= dateFin)}">
                <c:set var="hasReservations" value="true" />
            </c:if>
        </c:forEach>
        
        <c:choose>
            <c:when test="${hasReservations}">
                <table class="reservations-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Livre</th>
                            <th>Date réservation</th>
                            <th>Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reservation" items="${reservations}">
                            <c:if test="${reservation.adherent.id == adherent.id
                                && (empty dateDebut || reservation.dateReservation >= dateDebut)
                                && (empty dateFin || reservation.dateReservation <= dateFin)}">
                                <tr>
                                    <td>
                                        <span class="reservation-id">#${reservation.id}</span>
                                    </td>
                                    <td>
                                        <span class="book-title">${reservation.livre.titre}</span>
                                    </td>
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
                                                <span class="status-badge status-${dernierStatut.etat.toLowerCase().replace(' ', '-')}">${dernierStatut.etat}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-en-attente">En attente</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>Aucune réservation trouvée</h3>
                    <p>Vous n'avez pas encore de réservations pour cette période.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>