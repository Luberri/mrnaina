<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    com.bibliotheque.naina.model.Adherent adherent = (com.bibliotheque.naina.model.Adherent) session.getAttribute("adherent");
    Long roleId = adherent != null && adherent.getRole() != null ? adherent.getRole().getId() : null;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Bibliothèque Naina'}</title>

    <style>
        /* Variables CSS */
        :root {
            --primary-color: #667eea;
            --primary-dark: #5a6fd8;
            --secondary-color: #764ba2;
            --accent-color: #f093fb;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --error-color: #ef4444;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --text-light: #9ca3af;
            --bg-primary: #ffffff;
            --bg-secondary: #f8fafc;
            --bg-tertiary: #f1f5f9;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            --radius-sm: 0.375rem;
            --radius-md: 0.5rem;
            --radius-lg: 0.75rem;
            --radius-xl: 1rem;
        }

        /* Reset & Base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* Layout Container */
        .app-container {
            display: flex;
            min-height: 100vh;
            position: relative;
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--border-color);
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            text-align: center;
        }

        .sidebar-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: #ffffff;
        }

        .sidebar-header p {
            font-size: 0.875rem;
            opacity: 0.9;
            font-weight: 400;
        }

        .sidebar-nav {
            padding: 1.5rem 0;
        }

        .nav-section {
            margin-bottom: 2rem;
        }

        .nav-section-title {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-light);
            text-transform: uppercase;
            letter-spacing: 0.1em;
            padding: 0 1.5rem;
            margin-bottom: 1rem;
        }

        .nav-item {
            position: relative;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            border-left: 3px solid transparent;
        }

        .nav-link:hover {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.1), transparent);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        .nav-link.active {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.15), transparent);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        .nav-link::before {
            content: '';
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
            margin-right: 0.75rem;
            flex-shrink: 0;
        }

        .nav-link.dropdown-toggle::after {
            content: '';
            width: 0;
            height: 0;
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-top: 6px solid currentColor;
            margin-left: auto;
            transition: transform 0.3s ease;
        }

        .nav-link.dropdown-active::after {
            transform: rotate(180deg);
        }

        .dropdown-menu {
            max-height: 0;
            overflow: hidden;
            background: rgba(102, 126, 234, 0.05);
            transition: max-height 0.3s ease, padding 0.3s ease;
        }

        .dropdown-menu.active {
            max-height: 300px;
            padding: 0.5rem 0;
        }

        .dropdown-link {
            display: block;
            padding: 0.75rem 1.5rem 0.75rem 3.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 0.875rem;
            transition: all 0.2s ease;
            position: relative;
        }

        .dropdown-link::after {
            content: '';
            position: absolute;
            left: 2.5rem;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 4px;
            background: var(--text-light);
            border-radius: 50%;
        }

        .dropdown-link:hover {
            background: rgba(102, 126, 234, 0.1);
            color: var(--primary-color);
        }

        .logout-link {
            margin-top: 2rem;
            border-top: 1px solid var(--border-color);
            padding-top: 1rem;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 280px;
            min-height: 100vh;
            background: var(--bg-secondary);
        }

        .main-header {
            background: var(--bg-primary);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            border-bottom: 1px solid var(--border-color);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .header-info h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .header-info p {
            color: var(--text-secondary);
            font-size: 1rem;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-avatar {
            width: 3rem;
            height: 3rem;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .user-info h3 {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
        }

        .user-info p {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        /* Content Area */
        .content-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .content-card {
            background: var(--bg-primary);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            border: 1px solid var(--border-color);
        }

        /* Alerts */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--radius-lg);
            margin-bottom: 1.5rem;
            border: 1px solid;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
        }

        .alert-success {
            background: linear-gradient(90deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.05));
            color: var(--success-color);
            border-color: rgba(16, 185, 129, 0.2);
        }

        .alert-error {
            background: linear-gradient(90deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.05));
            color: var(--error-color);
            border-color: rgba(239, 68, 68, 0.2);
        }

        .alert-success::before {
            content: '✓';
            font-weight: bold;
            font-size: 1.2rem;
        }

        .alert-error::before {
            content: '✗';
            font-weight: bold;
            font-size: 1.2rem;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        input, select, textarea {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid var(--border-color);
            border-radius: var(--radius-md);
            font-size: 1rem;
            background: var(--bg-primary);
            transition: all 0.2s ease;
            font-family: inherit;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn{
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border: none;
            padding: 0.875rem 2rem;
            border-radius: var(--radius-md);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            margin: 1rem 0;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn:active, input[type="submit"]:active, input[type="button"]:active {
            transform: translateY(0);
        }

        /* Tables */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
            background: var(--bg-primary);
            border-radius: var(--radius-lg);
            overflow: hidden;
            box-shadow: var(--shadow-sm);
        }

        th, td {
            padding: 1rem 1.5rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background: var(--bg-tertiary);
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        tr:hover {
            background: rgba(102, 126, 234, 0.05);
        }

        tr:last-child td {
            border-bottom: none;
        }

        /* Autocomplete */
        .autocomplete-container {
            position: relative;
        }

        .autocomplete-items {
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: var(--bg-primary);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-lg);
            z-index: 1000;
            max-height: 200px;
            overflow-y: auto;
        }
.btn-accept {
    background: #4CAF50 ;
    color: white ;
}

.btn-refuse {
    background: #f44336 ;
    color: white ;
}
        .autocomplete-items div {
            padding: 0.875rem 1rem;
            cursor: pointer;
            border-bottom: 1px solid var(--border-color);
            transition: background 0.2s ease;
        }

        .autocomplete-items div:hover {
            background: rgba(102, 126, 234, 0.1);
        }

        .autocomplete-items div:last-child {
            border-bottom: none;
        }

        .autocomplete-active {
            background: var(--primary-color) !important;
            color: white !important;
        }

        /* Footer */
        footer {
            background: var(--bg-primary);
            padding: 2rem;
            text-align: center;
            color: var(--text-secondary);
            border-top: 1px solid var(--border-color);
            margin-top: 3rem;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                transform: translateX(-100%);
                position: fixed;
                z-index: 2000;
            }
            
            .sidebar.mobile-open {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .header-content {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .content-wrapper {
                padding: 1rem;
            }
            
            .mobile-menu-toggle {
                display: block;
                position: fixed;
                top: 1rem;
                left: 1rem;
                z-index: 2100;
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 0.75rem;
                border-radius: var(--radius-md);
                cursor: pointer;
                box-shadow: var(--shadow-md);
            }
        }

        @media (min-width: 769px) {
            .mobile-menu-toggle {
                display: none;
            }
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .content-card {
            animation: fadeIn 0.6s ease-out;
        }

        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: var(--bg-tertiary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 3px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-dark);
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Mobile Menu Toggle -->
        <button class="btn" class="mobile-menu-toggle" onclick="toggleMobileMenu()"></button>

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h2>Bibliothek</h2>
                <p>Système de gestion</p>
            </div>
            
            <nav class="sidebar-nav">
                <c:choose>
                    <c:when test="<%= roleId != null && roleId == 1L %>">
                        <!-- Admin : accès complet -->
                        <div class="nav-section">
                            <h3 class="nav-section-title">Gestion</h3>
                            
                            <div class="nav-item">
                                <a href="#" class="nav-link dropdown-toggle" data-dropdown="adherents">
                                    <span>👥 Adhérents</span>
                                </a>
                                <div class="dropdown-menu" id="adherents-dropdown">
                                    <a href="${pageContext.request.contextPath}/adherents" class="dropdown-link">
                                        Liste des adhérents
                                    </a>
                                    <a href="${pageContext.request.contextPath}/adherents/nouveau" class="dropdown-link">
                                        Ajouter un adhérent
                                    </a>
                                </div>
                            </div>

                            <div class="nav-item">
                                <a href="#" class="nav-link dropdown-toggle" data-dropdown="livres">
                                    <span>📖 Livres</span>
                                </a>
                                <div class="dropdown-menu" id="livres-dropdown">
                                    <a href="${pageContext.request.contextPath}/livres" class="dropdown-link">
                                        Catalogue
                                    </a>
                                    <a href="${pageContext.request.contextPath}/livres/nouveau" class="dropdown-link">
                                        Ajouter un livre
                                    </a>
                                </div>
                            </div>

                            <div class="nav-item">
                                <a href="#" class="nav-link dropdown-toggle" data-dropdown="prets">
                                    <span>🤝 Prêts</span>
                                </a>
                                <div class="dropdown-menu" id="prets-dropdown">
                                    <a href="${pageContext.request.contextPath}/prets" class="dropdown-link">
                                        Liste des prêts
                                    </a>
                                    <a href="${pageContext.request.contextPath}/prets/nouveau" class="dropdown-link">
                                        Nouveau prêt
                                    </a>
                                    <a href="${pageContext.request.contextPath}/prolongements" class="dropdown-link">
                                        demande de prolongement
                                    </a>
                                </div>
                            </div>

                            <div class="nav-item">
                                <a href="#" class="nav-link dropdown-toggle" data-dropdown="abonnements">
                                    <span>🆔 Abonnements</span>
                                </a>
                                <div class="dropdown-menu" id="abonnements-dropdown">
                                    <a href="${pageContext.request.contextPath}/abonnements" class="dropdown-link">
                                        Liste des abonnements
                                    </a>
                                    <a href="${pageContext.request.contextPath}/abonnement/nouveau" class="dropdown-link">
                                        Nouvel abonnement
                                    </a>
                                </div>
                            </div>
                            <div class="nav-item">
                                <a href="#" class="nav-link dropdown-toggle" data-dropdown="reservations">
                                    <span>🎟️ Reservation</span>
                                </a>
                                <div class="dropdown-menu" id="reservations-dropdown">
                                    <a href="${pageContext.request.contextPath}/reservations" class="dropdown-link">
                                        Liste des réservations
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Utilisateur normal -->
                        <div class="nav-section">
                            <h3 class="nav-section-title">Catalogue</h3>
                            <div class="nav-item">
                                <a href="${pageContext.request.contextPath}/livres" class="nav-link">
                                    <span>📖 Livres disponibles</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/mes-reservations" class="nav-link">
                                    <span>📅 Mes réservations</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/mes-prets" class="nav-link">
                                    <span>📚 Mes prêts en cours</span>
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="nav-section logout-link">
                    <div class="nav-item">
                        <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                            <span>🚪 Déconnexion</span>
                        </a>
                    </div>
                </div>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <header class="main-header">
                <div class="header-content">
                    <div class="header-info">
                        <h1>Bibliothèque Naina</h1>
                        <p>Système de gestion moderne et intuitif</p>
                    </div>
                    <div class="user-profile">
                        <% if (adherent != null && adherent.getNom() != null) { %>
                            <div class="user-avatar">
                                <%= adherent.getNom().substring(0, 1).toUpperCase() %>
                            </div>
                            <div class="user-info">
                                <h3><%= adherent.getNom() %></h3>
                                <p><%= roleId != null && roleId == 1L ? "Administrateur" : "Utilisateur" %></p>
                            </div>
                        <% } else { %>
                            <div class="user-avatar">
                                👤
                            </div>
                            <div class="user-info">
                                <h3>Utilisateur</h3>
                                <p>Invité</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </header>

            <main class="content-wrapper">
                <div class="content-card">
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">
                            <span>${message}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <span>${error}</span>
                        </div>
                    </c:if>
                    
                    <jsp:include page="${body}" />
                </div>
            </main>

            <footer>
                <p>&copy; 2025 Bibliothèque Naina — Système de gestion universitaire</p>
            </footer>
        </div>
    </div>

    <script>
        // Dropdown functionality
        document.addEventListener('DOMContentLoaded', function() {
            const dropdownToggles = document.querySelectorAll('.dropdown-toggle');
            
            dropdownToggles.forEach(toggle => {
                toggle.addEventListener('click', function(e) {
                    e.preventDefault();
                    
                    const dropdownId = this.getAttribute('data-dropdown') + '-dropdown';
                    const dropdown = document.getElementById(dropdownId);
                    
                    // Close other dropdowns
                    document.querySelectorAll('.dropdown-menu').forEach(menu => {
                        if (menu.id !== dropdownId) {
                            menu.classList.remove('active');
                        }
                    });
                    
                    document.querySelectorAll('.dropdown-toggle').forEach(t => {
                        if (t !== this) {
                            t.classList.remove('dropdown-active');
                        }
                    });
                    
                    // Toggle current dropdown
                    dropdown.classList.toggle('active');
                    this.classList.toggle('dropdown-active');
                });
            });
        });

        // Mobile menu functionality
        function toggleMobileMenu() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('mobile-open');
        }

        // Close mobile menu when clicking outside
        document.addEventListener('click', function(e) {
            const sidebar = document.getElementById('sidebar');
            const menuToggle = document.querySelector('.mobile-menu-toggle');
            
            if (!sidebar.contains(e.target) && !menuToggle.contains(e.target)) {
                sidebar.classList.remove('mobile-open');
            }
        });

        // Auto-close mobile menu on navigation
        document.querySelectorAll('.nav-link, .dropdown-link').forEach(link => {
            link.addEventListener('click', function() {
                if (window.innerWidth <= 768) {
                    document.getElementById('sidebar').classList.remove('mobile-open');
                }
            });
        });
    </script>
</body>
</html>