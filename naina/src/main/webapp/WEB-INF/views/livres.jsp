<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    com.bibliotheque.naina.model.Adherent adherent = (com.bibliotheque.naina.model.Adherent) session.getAttribute("adherent");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des livres</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            color: white;
            font-size: 2.5rem;
            font-weight: 300;
            margin-bottom: 10px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        .search-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            border: 1px solid rgba(255,255,255,0.2);
        }

        .search-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #555;
            font-size: 0.9rem;
        }

        .form-group input,
        .form-group select {
            padding: 12px 16px;
            border: 2px solid #e1e8ed;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .filter-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            min-height: 48px;
        }

        .filter-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .books-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .book-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .book-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .book-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .book-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
            line-height: 1.3;
        }

        .book-info {
            margin-bottom: 15px;
        }

        .book-info strong {
            color: #34495e;
            font-weight: 600;
        }

        .book-info span {
            color: #7f8c8d;
        }

        .categories-section {
            margin: 20px 0;
        }

        .categories-section strong {
            color: #34495e;
            font-weight: 600;
            display: block;
            margin-bottom: 10px;
        }

        .categories-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .category-tag {
            background: linear-gradient(135deg, #667eea20, #764ba220);
            color: #5a67d8;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            border: 1px solid rgba(102, 126, 234, 0.2);
            transition: all 0.2s ease;
        }

        .category-tag:hover {
            background: linear-gradient(135deg, #667eea30, #764ba230);
            transform: translateY(-1px);
        }

        .availability {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 15px 0;
            padding: 12px;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 12px;
            border-left: 4px solid #3498db;
        }

        .availability strong {
            color: #2980b9;
        }

        .availability-count {
            background: #3498db;
            color: white;
            padding: 4px 8px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .reserve-btn {
            background: linear-gradient(135deg, #00b894, #00a085);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 15px;
        }

        .reserve-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 184, 148, 0.3);
        }

        .logout-container {
            text-align: center;
            margin-top: 40px;
        }

        .logout-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid rgba(255, 255, 255, 0.3);
            display: inline-block;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: rgba(255, 255, 255, 0.8);
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 1rem;
            opacity: 0.8;
        }

        @media (max-width: 768px) {
            .books-grid {
                grid-template-columns: 1fr;
            }
            
            .search-form {
                grid-template-columns: 1fr;
            }
            
            .header h1 {
                font-size: 2rem;
                color: black;
            }
            
            body {
                padding: 10px;
            }
        }

        @media (max-width: 480px) {
            .search-container {
                padding: 20px;
            }
            
            .book-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1 style="color: black;">📚 Nos Livres</h1>
        </div>

        <div class="search-container">
            <form method="get" action="${pageContext.request.contextPath}/livres" class="search-form">
                <div class="form-group">
                    <label for="categorie">Catégorie</label>
                    <select name="categorie" id="categorie">
                        <option value="">Toutes les catégories</option>
                        <c:forEach var="cat" items="${allCategories}">
                            <option value="${cat}" <c:if test="${cat == selectedCategorie}">selected</c:if>>${cat}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="titre">Titre du livre</label>
                    <input type="text" name="titre" id="titre" value="${searchTitre != null ? searchTitre : ''}" placeholder="Rechercher par titre..."/>
                </div>
                
                <div class="form-group">
                    <label for="auteur">Auteur</label>
                    <input type="text" name="auteur" id="auteur" value="${searchAuteur != null ? searchAuteur : ''}" placeholder="Rechercher par auteur..."/>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="filter-btn">Filtrer</button>
                </div>
            </form>
        </div>

        <div class="books-grid">
            <c:choose>
                <c:when test="${not empty livres}">
                    <c:forEach var="livre" items="${livres}">
                        <div class="book-card">
                            <h3 class="book-title">${livre.titre}</h3>
                            
                            <div class="book-info">
                                <strong>✍️ Auteur:</strong> <span>${livre.auteur}</span>
                            </div>
                            
                            <div class="categories-section">
                                <div class="categories-list">
                                    <c:forEach var="cat" items="${livreCategories[livre.id]}">
                                        <span class="category-tag">${cat}</span>
                                    </c:forEach>
                                </div>
                            </div>
                            
                            <div class="availability">
                                <strong>📖 Disponibilité:</strong>
                                <span class="availability-count">
                                    <c:out value="${exemplairesDisponibles[livre.id]}" /> exemplaire(s)
                                </span>
                            </div>
                            
                            <c:if test="${adherent != null && adherent.role.id != 1}">
                                <form action="${pageContext.request.contextPath}/reservations/nouveau" method="get">
                                    <input type="hidden" name="livreId" value="${livre.id}" />
                                    <button type="submit" class="reserve-btn">
                                        Réserver
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>🔍 Aucun livre trouvé</h3>
                        <p>Essayez de modifier vos critères de recherche</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="logout-container">
            <a class="logout-btn" href="${pageContext.request.contextPath}/logout">
                🚪 Déconnexion
            </a>
        </div>
    </div>
</body>
</html>