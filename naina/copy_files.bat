@echo off
setlocal enabledelayedexpansion

:: Source and destination directories
set "SOURCE_DIR=D:\S4\optim-Aina\ireto"
set "DEST_DIR=D:\S4\optim-Aina\naina"

:: Create necessary directories in the destination project if they don't exist
mkdir "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model"
mkdir "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository"
mkdir "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service"
mkdir "%DEST_DIR%\src\main\java\com\bibliotheque\naina\controller"
mkdir "%DEST_DIR%\src\main\resources\static\css"

:: Copy pom.xml to the root of the project
echo Copying pom.xml...
copy "%SOURCE_DIR%\pom.xml" "%DEST_DIR%\pom.xml"

:: Copy application.properties to src/main/resources
echo Copying application.properties...
copy "%SOURCE_DIR%\application.properties" "%DEST_DIR%\src\main\resources\application.properties"

:: Copy Java files to their respective package directories
echo Copying Java model files...
copy "%SOURCE_DIR%\Role.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Role.java"
copy "%SOURCE_DIR%\Adherent.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Adherent.java"
copy "%SOURCE_DIR%\Categorie.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Categorie.java"
copy "%SOURCE_DIR%\Livre.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Livre.java"
copy "%SOURCE_DIR%\LivreCategorie.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\LivreCategorie.java"
copy "%SOURCE_DIR%\Exemplaire.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Exemplaire.java"
copy "%SOURCE_DIR%\Mode.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Mode.java"
copy "%SOURCE_DIR%\Pret.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Pret.java"
copy "%SOURCE_DIR%\PretJour.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\PretJour.java"
copy "%SOURCE_DIR%\Abonnement.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Abonnement.java"
copy "%SOURCE_DIR%\AbonnementTarif.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\AbonnementTarif.java"
copy "%SOURCE_DIR%\Reservation.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\Reservation.java"
copy "%SOURCE_DIR%\ReservationRole.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\model\ReservationRole.java"

echo Copying Java repository files...
copy "%SOURCE_DIR%\RoleRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\RoleRepository.java"
copy "%SOURCE_DIR%\AdherentRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\AdherentRepository.java"
copy "%SOURCE_DIR%\CategorieRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\CategorieRepository.java"
copy "%SOURCE_DIR%\LivreRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\LivreRepository.java"
copy "%SOURCE_DIR%\LivreCategorieRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\LivreCategorieRepository.java"
copy "%SOURCE_DIR%\ExemplaireRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\ExemplaireRepository.java"
copy "%SOURCE_DIR%\ModeRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\ModeRepository.java"
copy "%SOURCE_DIR%\PretRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\PretRepository.java"
copy "%SOURCE_DIR%\PretJourRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\PretJourRepository.java"
copy "%SOURCE_DIR%\AbonnementRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\AbonnementRepository.java"
copy "%SOURCE_DIR%\AbonnementTarifRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\AbonnementTarifRepository.java"
copy "%SOURCE_DIR%\ReservationRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\ReservationRepository.java"
copy "%SOURCE_DIR%\ReservationRoleRepository.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\repository\ReservationRoleRepository.java"

echo Copying Java service files...
copy "%SOURCE_DIR%\RoleService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\RoleService.java"
copy "%SOURCE_DIR%\AdherentService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\AdherentService.java"
copy "%SOURCE_DIR%\CategorieService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\CategorieService.java"
copy "%SOURCE_DIR%\LivreService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\LivreService.java"
copy "%SOURCE_DIR%\LivreCategorieService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\LivreCategorieService.java"
copy "%SOURCE_DIR%\ExemplaireService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\ExemplaireService.java"
copy "%SOURCE_DIR%\ModeService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\ModeService.java"
copy "%SOURCE_DIR%\PretService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\PretService.java"
copy "%SOURCE_DIR%\PretJourService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\PretJourService.java"
copy "%SOURCE_DIR%\AbonnementService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\AbonnementService.java"
copy "%SOURCE_DIR%\AbonnementTarifService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\AbonnementTarifService.java"
copy "%SOURCE_DIR%\ReservationService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\ReservationService.java"
copy "%SOURCE_DIR%\ReservationRoleService.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\service\ReservationRoleService.java"

echo Copying Java controller files...
copy "%SOURCE_DIR%\AdherentController.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\controller\AdherentController.java"
copy "%SOURCE_DIR%\LivreController.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\controller\LivreController.java"
copy "%SOURCE_DIR%\PretController.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\controller\PretController.java"
copy "%SOURCE_DIR%\ReservationController.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\controller\ReservationController.java"

echo Copying CSS file...
copy "%SOURCE_DIR%\style.css" "%DEST_DIR%\src\main\resources\static\css\style.css"

:: Copy main application file
echo Copying main application file...
copy "%SOURCE_DIR%\NainaApplication.java" "%DEST_DIR%\src\main\java\com\bibliotheque\naina\NainaApplication.java"

echo File copying completed.
pause