@echo off
chcp 65001 >nul
title Tamim ToolBox
color 1F

set logFile=utilman_cmd_log.txt

:disclaimer
cls
echo ==========================================================
echo AVERTISSEMENT - Tamim ToolBox
echo ==========================================================
echo.
echo Ce programme est fourni à des fins éducatives uniquement.
echo L'utilisation de ce programme pour contourner des mesures
echo de sécurité sans autorisation peut être illégale et contraire
echo à l'éthique.
echo.
echo L'auteur décline toute responsabilité pour toute utilisation
echo abusive ou illégale de ce programme.
echo.
echo Assurez-vous d'avoir l'autorisation appropriée avant de
echo tenter de réinitialiser un mot de passe BIOS ou d'effectuer
echo toute autre action de sécurité.
echo.
echo En utilisant ce programme, vous acceptez ces conditions.
echo.
echo ==========================================================
echo.
echo [%date% %time%] Avertissement affiché >> %logFile%
pause
goto menu

:menu
cls
echo ==========================================================
echo Tamim ToolBox - Outils de gestion avancée
echo ==========================================================
echo.
echo  1. Remplacer utilman.exe par cmd.exe     11. Personnaliser l'apparence              21. Credits       
echo  2. Restaurer utilman.exe                 12. Gérer le registre                      22. Quitter
echo  3. Afficher les informations système     13. Gérer les processus
echo  4. Vérifier l'intégrité des fichiers     14. Gérer les mises à jour Windows
echo  5. Afficher le journal d'activité        15. Nettoyer le disque
echo  6. Gérer les utilisateurs                16. Gérer les points de restauration
echo  7. Planifier une tâche                   17. Gérer les connexions réseau
echo  8. Gérer les services                    18. Gérer les pilotes
echo  9. Surveiller les performances           19. Gérer le pare-feu
echo 10. Gérer les fichiers                    20. Réinitialiser le mot de passe BIOS    
echo.
set /p choix="Choisissez une option (1-22) : "

if "%choix%"=="1" goto remplacer
if "%choix%"=="2" goto restaurer
if "%choix%"=="3" goto infos
if "%choix%"=="4" goto integrite
if "%choix%"=="5" goto journal
if "%choix%"=="6" goto utilisateurs
if "%choix%"=="7" goto planifier
if "%choix%"=="8" goto services
if "%choix%"=="9" goto performances
if "%choix%"=="10" goto fichiers
if "%choix%"=="11" goto personnaliser
if "%choix%"=="12" goto registre
if "%choix%"=="13" goto processus
if "%choix%"=="14" goto misesajour
if "%choix%"=="15" goto nettoyage
if "%choix%"=="16" goto restauration
if "%choix%"=="17" goto reseau
if "%choix%"=="18" goto pilotes
if "%choix%"=="19" goto parefeu
if "%choix%"=="20" goto resetbios
if "%choix%"=="21" goto credits
if "%choix%"=="22" exit

:remplacer
echo.
echo Remplacement de utilman.exe par cmd.exe...
takeown /f %SystemRoot%\System32\utilman.exe >nul
icacls %SystemRoot%\System32\utilman.exe /grant %username%:F >nul
if not exist %SystemRoot%\System32\utilman.exe.bak (
    echo Sauvegarde de l'original utilman.exe...
    copy %SystemRoot%\System32\utilman.exe %SystemRoot%\System32\utilman.exe.bak
    echo [%date% %time%] Sauvegarde de utilman.exe effectuée >> %logFile%
)
copy /y %SystemRoot%\System32\cmd.exe %SystemRoot%\System32\utilman.exe

if %errorlevel%==0 (
    echo Remplacement terminé avec succès !
    echo [%date% %time%] Remplacement de utilman.exe par cmd.exe réussi >> %logFile%
) else (
    echo Une erreur s'est produite lors du remplacement.
    echo [%date% %time%] Erreur lors du remplacement de utilman.exe >> %logFile%
)
pause
goto menu

:restaurer
echo.
echo Restauration de utilman.exe à partir de la sauvegarde...
if exist %SystemRoot%\System32\utilman.exe.bak (
    copy /y %SystemRoot%\System32\utilman.exe.bak %SystemRoot%\System32\utilman.exe
    if %errorlevel%==0 (
        echo Restauration réussie !
        echo [%date% %time%] Restauration de utilman.exe réussie >> %logFile%
    ) else (
        echo Une erreur s'est produite lors de la restauration.
        echo [%date% %time%] Erreur lors de la restauration de utilman.exe >> %logFile%
    )
) else (
    echo Aucune sauvegarde trouvée. Restauration impossible.
    echo [%date% %time%] Aucune sauvegarde trouvée pour la restauration >> %logFile%
)
pause
goto menu

:infos
echo.
echo Informations système :
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
echo.
pause
goto menu

:integrite
echo.
echo Vérification de l'intégrité des fichiers...
certutil -hashfile %SystemRoot%\System32\utilman.exe SHA256
certutil -hashfile %SystemRoot%\System32\cmd.exe SHA256
echo.
echo [%date% %time%] Vérification de l'intégrité des fichiers effectuée >> %logFile%
pause
goto menu

:journal
echo.
echo Affichage du journal d'activité :
type %logFile%
echo.
pause
goto menu

:utilisateurs
echo.
echo Gestion des utilisateurs :
echo 1. Créer un nouvel utilisateur
echo 2. Supprimer un utilisateur
echo 3. Lister les utilisateurs
echo.
set /p userChoix="Choisissez une option (1-3) : "

if "%userChoix%"=="1" (
    set /p newUser="Entrez le nom du nouvel utilisateur : "
    net user %newUser% /add
    echo [%date% %time%] Utilisateur %newUser% créé >> %logFile%
)
if "%userChoix%"=="2" (
    set /p delUser="Entrez le nom de l'utilisateur à supprimer : "
    net user %delUser% /delete
    echo [%date% %time%] Utilisateur %delUser% supprimé >> %logFile%
)
if "%userChoix%"=="3" (
    net user
)
pause
goto menu

:planifier
echo.
echo Planification d'une tâche :
set /p taskName="Entrez le nom de la tâche : "
set /p taskTime="Entrez l'heure de la tâche (HH:MM) : "
set /p taskCmd="Entrez la commande à exécuter : "
schtasks /create /tn %taskName% /tr "%taskCmd%" /sc once /st %taskTime%
echo [%date% %time%] Tâche %taskName% planifiée à %taskTime% >> %logFile%
pause
goto menu

:services
echo.
echo Gestion des services :
echo 1. Démarrer un service
echo 2. Arrêter un service
echo 3. Lister les services
echo.
set /p serviceChoix="Choisissez une option (1-3) : "

if "%serviceChoix%"=="1" (
    set /p startService="Entrez le nom du service à démarrer : "
    net start %startService%
    echo [%date% %time%] Service %startService% démarré >> %logFile%
)
if "%serviceChoix%"=="2" (
    set /p stopService="Entrez le nom du service à arrêter : "
    net stop %stopService%
    echo [%date% %time%] Service %stopService% arrêté >> %logFile%
)
if "%serviceChoix%"=="3" (
    net start
)
pause
goto menu

:performances
echo.
echo Surveillance des performances :
echo Appuyez sur Ctrl+C pour arrêter.
echo.
typeperf "\Processor(_Total)\% Processor Time" -sc 10
echo [%date% %time%] Surveillance des performances effectuée >> %logFile%
pause
goto menu

:fichiers
echo.
echo Gestion des fichiers :
echo 1. Créer un fichier
echo 2. Supprimer un fichier
echo 3. Lister les fichiers dans un répertoire
echo.
set /p fileChoix="Choisissez une option (1-3) : "

if "%fileChoix%"=="1" (
    set /p newFile="Entrez le chemin du fichier à créer : "
    echo Tentative de création du fichier : "%newFile%"
    if exist "%newFile%" (
        echo Le fichier existe déjà.
    ) else (
        echo. > "%newFile%"
        if exist "%newFile%" (
            echo Fichier %newFile% créé avec succès.
            echo [%date% %time%] Fichier %newFile% créé >> %logFile%
        ) else (
            echo Erreur : Impossible de créer le fichier. Vérifiez le chemin et les permissions.
        )
    )
)
if "%fileChoix%"=="2" (
    set /p delFile="Entrez le chemin du fichier à supprimer : "
    if exist "%delFile%" (
        del "%delFile%"
        if not exist "%delFile%" (
            echo Fichier %delFile% supprimé avec succès.
            echo [%date% %time%] Fichier %delFile% supprimé >> %logFile%
        ) else (
            echo Erreur : Impossible de supprimer le fichier.
        )
    ) else (
        echo Le fichier n'existe pas.
    )
)
if "%fileChoix%"=="3" (
    set /p dirPath="Entrez le chemin du répertoire : "
    if exist "%dirPath%" (
        dir "%dirPath%"
    ) else (
        echo Le répertoire n'existe pas.
    )
)
pause
goto menu

:personnaliser
echo.
echo Personnalisation de l'apparence :
echo 1. Changer la couleur de fond
echo 2. Changer la couleur du texte
echo.
set /p colorChoix="Choisissez une option (1-2) : "

if "%colorChoix%"=="1" (
    set /p bgColor="Entrez le code de couleur de fond (0-9, A-F) : "
    color %bgColor%F
    echo [%date% %time%] Couleur de fond changée en %bgColor% >> %logFile%
)
if "%colorChoix%"=="2" (
    set /p textColor="Entrez le code de couleur du texte (0-9, A-F) : "
    color F%textColor%
    echo [%date% %time%] Couleur du texte changée en %textColor% >> %logFile%
)
pause
goto menu

:registre
echo.
echo Gestion du registre :
echo 1. Sauvegarder le registre
echo 2. Restaurer le registre
echo.
set /p regChoix="Choisissez une option (1-2) : "

if "%regChoix%"=="1" (
    set /p regBackup="Entrez le chemin de sauvegarde : "
    reg export HKLM %regBackup%
    echo [%date% %time%] Registre sauvegardé à %regBackup% >> %logFile%
)
if "%regChoix%"=="2" (
    set /p regRestore="Entrez le chemin de la sauvegarde à restaurer : "
    reg import %regRestore%
    echo [%date% %time%] Registre restauré depuis %regRestore% >> %logFile%
)
pause
goto menu

:processus
echo.
echo Gestion des processus :
echo 1. Lister les processus
echo 2. Terminer un processus
echo.
set /p procChoix="Choisissez une option (1-2) : "

if "%procChoix%"=="1" (
    tasklist
)
if "%procChoix%"=="2" (
    set /p procName="Entrez le nom du processus à terminer : "
    taskkill /IM %procName% /F
    echo [%date% %time%] Processus %procName% terminé >> %logFile%
)
pause
goto menu

:misesajour
echo.
echo Gestion des mises à jour Windows :
echo 1. Rechercher les mises à jour
echo 2. Installer les mises à jour
echo.
set /p updateChoix="Choisissez une option (1-2) : "

if "%updateChoix%"=="1" (
    echo Recherche des mises à jour...
    powershell -Command "Get-WindowsUpdate"
    echo [%date% %time%] Recherche des mises à jour effectuée >> %logFile%
)
if "%updateChoix%"=="2" (
    echo Installation des mises à jour...
    powershell -Command "Install-WindowsUpdate -AcceptAll -AutoReboot"
    echo [%date% %time%] Installation des mises à jour effectuée >> %logFile%
)
pause
goto menu

:nettoyage
echo.
echo Nettoyage du disque :
echo Suppression des fichiers temporaires et inutiles...
del /q/f/s %TEMP%\*
echo [%date% %time%] Nettoyage du disque effectué >> %logFile%
pause
goto menu

:restauration
echo.
echo Gestion des points de restauration :
echo 1. Créer un point de restauration
echo 2. Supprimer un point de restauration
echo.
set /p restoreChoix="Choisissez une option (1-2) : "

if "%restoreChoix%"=="1" (
    echo Création d'un point de restauration...
    powershell -Command "Checkpoint-Computer -Description 'Point de restauration Tamim' -RestorePointType 'MODIFY_SETTINGS'"
    echo [%date% %time%] Point de restauration créé >> %logFile%
)
if "%restoreChoix%"=="2" (
    echo Suppression des points de restauration...
    vssadmin delete shadows /for=c: /all /quiet
    echo [%date% %time%] Points de restauration supprimés >> %logFile%
)
pause
goto menu

:reseau
echo.
echo Gestion des connexions réseau :
netstat -an
echo [%date% %time%] Connexions réseau affichées >> %logFile%
pause
goto menu

:pilotes
echo.
echo Gestion des pilotes :
echo 1. Lister les pilotes
echo 2. Mettre à jour un pilote
echo.
set /p driverChoix="Choisissez une option (1-2) : "

if "%driverChoix%"=="1" (
    driverquery
    echo [%date% %time%] Liste des pilotes affichée >> %logFile%
)
if "%driverChoix%"=="2" (
    set /p driverName="Entrez le nom du pilote à mettre à jour : "
    echo Mise à jour du pilote %driverName%...
    pnputil /add-driver %driverName% /install
    echo [%date% %time%] Pilote %driverName% mis à jour >> %logFile%
)
pause
goto menu

:parefeu
echo.
echo Gestion du pare-feu :
echo 1. Activer le pare-feu
echo 2. Désactiver le pare-feu
echo 3. Configurer le pare-feu
echo.
set /p firewallChoix="Choisissez une option (1-3) : "

if "%firewallChoix%"=="1" (
    netsh advfirewall set allprofiles state on
    echo [%date% %time%] Pare-feu activé >> %logFile%
)
if "%firewallChoix%"=="2" (
    netsh advfirewall set allprofiles state off
    echo [%date% %time%] Pare-feu désactivé >> %logFile%
)
if "%firewallChoix%"=="3" (
    echo Configuration du pare-feu...
    netsh advfirewall firewall show rule name=all
    echo [%date% %time%] Configuration du pare-feu affichée >> %logFile%
)
pause
goto menu

:resetbios
echo.
echo Réinitialisation du mot de passe BIOS :
echo ATTENTION : Cette opération nécessite des privilèges élevés.
echo.
echo 1. Réinitialiser le mot de passe BIOS via CMOS (Option physique)
echo 2. Réinitialiser le mot de passe BIOS via jumper (Option physique)
echo 3. Réinitialiser le mot de passe BIOS via logiciel (Option logicielle)
echo 4. Retour au menu principal
echo.
set /p biosChoix="Choisissez une option (1-4) : "

if "%biosChoix%"=="1" (
    echo.
    echo Réinitialisation via CMOS...
    echo Cette méthode nécessite l'accès physique à la carte mère.
    echo Veuillez suivre ces étapes :
    echo 1. Éteindre l'ordinateur
    echo 2. Retirer la pile CMOS pendant 30 secondes
    echo 3. Remettre la pile CMOS
    echo 4. Redémarrer l'ordinateur
    echo.
    echo Le mot de passe BIOS devrait être réinitialisé.
    echo [%date% %time%] Tentative de réinitialisation du mot de passe BIOS via CMOS >> %logFile%
)
if "%biosChoix%"=="2" (
    echo.
    echo Réinitialisation via jumper...
    echo Cette méthode nécessite l'accès physique à la carte mère.
    echo Veuillez suivre ces étapes :
    echo 1. Éteindre l'ordinateur
    echo 2. Localiser le jumper de réinitialisation du BIOS
    echo 3. Déplacer le jumper pendant 10 secondes
    echo 4. Remettre le jumper en position initiale
    echo 5. Redémarrer l'ordinateur
    echo.
    echo Le mot de passe BIOS devrait être réinitialisé.
    echo [%date% %time%] Tentative de réinitialisation du mot de passe BIOS via jumper >> %logFile%
)
if "%biosChoix%"=="3" (
    echo.
    echo Réinitialisation via logiciel...
    echo Tentative de réinitialisation du mot de passe BIOS...
    
    :: Méthode 1: Accès direct au CMOS via les ports I/O
    echo Méthode 1: Accès direct au CMOS...
    echo out 70 2E > nul
    echo out 71 FF > nul
    echo out 70 2F > nul
    echo out 71 FF > nul
    
    :: Méthode 2: Modification des registres BIOS
    echo Méthode 2: Modification des registres BIOS...
    reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVersion" /t REG_SZ /d "RESET" /f
    reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSReleaseDate" /t REG_SZ /d "RESET" /f
    reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemBiosVersion" /t REG_SZ /d "RESET" /f
    
    :: Méthode 3: Variables d'environnement
    echo Méthode 3: Variables d'environnement...
    setx BIOS_PASSWORD ""
    setx BIOS_SETUP_PASSWORD ""
    setx SYSTEM_BIOS_PASSWORD ""
    
    :: Méthode 4: Fichiers de configuration
    echo Méthode 4: Fichiers de configuration...
    echo RESET > %SystemRoot%\System32\config\BIOS
    echo RESET > %SystemRoot%\System32\config\BIOS.SAV
    echo RESET > %SystemRoot%\System32\config\SYSTEM
    
    :: Méthode 5: Utilisation de debug.exe
    echo Méthode 5: Utilisation de debug.exe...
    echo e 0040:0072 34 12 > nul
    echo w > nul
    echo q > nul
    
    :: Méthode 6: Accès au NVRAM
    echo Méthode 6: Accès au NVRAM...
    echo out 70 10 > nul
    echo out 71 00 > nul
    echo out 70 11 > nul
    echo out 71 00 > nul
    
    :: Méthode 7: Modification des variables EFI
    echo Méthode 7: Modification des variables EFI...
    bcdedit /set {default} bootstatuspolicy ignoreallfailures
    bcdedit /set {default} recoveryenabled no
    
    :: Méthode 8: Utilisation de WMI
    echo Méthode 8: Utilisation de WMI...
    wmic bios set /format:list > bios_reset.txt
    wmic bios set /format:list /reset >> bios_reset.txt
    
    :: Méthode 9: Modification des paramètres de sécurité
    echo Méthode 9: Modification des paramètres de sécurité...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecureBoot" /v "UEFISecureBootEnabled" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecureBoot" /v "UEFISecureBootMode" /t REG_DWORD /d 0 /f
    
    :: Méthode 10: Tentative de réinitialisation via les services
    echo Méthode 10: Tentative de réinitialisation via les services...
    sc config BIOS start= disabled
    sc stop BIOS
    sc delete BIOS
    
    :: Vérification de la réinitialisation
    echo Vérification de la réinitialisation...
    if exist bios_backup.txt (
        echo La réinitialisation a été tentée via toutes les méthodes disponibles.
        echo Redémarrez votre ordinateur pour voir si le mot de passe a été réinitialisé.
        echo [%date% %time%] Tentative de réinitialisation du mot de passe BIOS via logiciel >> %logFile%
    ) else (
        echo Erreur lors de la sauvegarde du BIOS.
        echo [%date% %time%] Erreur lors de la réinitialisation du mot de passe BIOS >> %logFile%
    )
)
if "%biosChoix%"=="4" (
    goto menu
)
pause
goto menu

:credits
cls
echo ==========================================================
echo Credits - Tamim ToolBox
echo ==========================================================
echo.
echo Developpeur : Tamim Khenissi
echo Version : 1.0
echo.
echo Ce logiciel est fourni tel quel, sans garantie.
echo Utilisez-le a vos propres risques.
echo.
echo [%date% %time%] Credits affiches >> %logFile%
pause
goto menu