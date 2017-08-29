*** Settings ***
Documentation    All XtremWeb commands line  tests
Resource  ../Resources/XWCommon.robot
Resource  ../Resources/XWServer.robot
Suite Setup  XWCommon.Start XWtremWeb Server And XWtremWeb Worker
Suite Teardown  XWCommon.Stop XWtremWeb Server And XWtremWeb Worker
Test Setup  XWCommon.Begin XWtremWeb Command Test
Test Teardown  XWCommon.End XWtremWeb Command Test


# to launch tests : pybot -d Results ./Tests/xwcommandsSuite.robot
*** Variables ***


*** Test Cases ***

Test envoyer des données
    [Documentation]  Envoyer des données avec la commande senddata
    [Tags]  CommandLine Tests
    ${uid} =  XWSENDDATACommand  ls  macosx  x86_64  binary  /bin/ls
    XWServer.Count From Datas Where Uid  ${uid}  1
    # TODO check also values : ls  macosx  x86_64  binary  /bin/ls in datas table


Test 1.1 Enregistrer l’application
    [Documentation]  Les premiers tests doivent permettre de tester la prise en compte de la ligne de commande et de l’environnement, un ensemble de fichiers copiés dans le répertoire courant du job, du côté du worker. L’application “LS” correspond à ces pré requis.
    [Tags]  CommandLine Tests
    LOG  Test 1.1 Enregistrer l’application
    ${uid} =  XWSENDAPPCommand  ls  deployable  macosx  x86_64  /bin/ls
    XWServer.Count From Apps Where Uid  ${uid}  1
    # TODO check also values : ls  deployable  macosx  x86_64  /bin/ls in apps table

Test 2.1 Soumettre un job sans ligne de commande
    [Documentation]  Ces tests doivent prouver que la ligne de commande est prise en charge correctement.
    [Tags]  CommandLine Tests
    LOG  TODO

Test 2.2 Soumettre un job avec ligne de commande
    [Documentation]  Ces tests doivent prouver que la ligne de commande est prise en charge correctement. Ces tests doivent se faire avec un application qui accepte des arguments sur la ligne de commande
    [Tags]  CommandLine Tests
    LOG  TODO

Test 3.2 Soumettre un job avec un petit environnement
    [Documentation]  Typiquement un fichier ou un répertoire de moins de 10Kb.
    [Tags]  CommandLine Tests
    LOG  TODO

Test 3.3 Soumettre un job avec un gros environnement
    [Documentation]  Typiquement un fichier ou un répertoire de plus de 1Mb.
    [Tags]  CommandLine Tests
    LOG  TODO

Test 4 Tester la ligne de commande et l’environnement
    [Tags]  CommandLine Tests
    LOG  TODO

Test 5 Tester le matchmaking
    [Documentation]  Ces test doivent prouver que le scheduler fonctionne correctement.Pour ce faire, il faut insérer une application avec un binaire qui ne correspond à aucun worker du déploiement. Pour ce test nous pouvons utiliser n’importe quelle application avec n’importe quel binaire. Il convient cependant de s’assurer qu’on enregistre l’application avec un type de binaire inutilisable pour le déploiement présenté dans l’introduction.
    [Tags]  CommandLine Tests
    LOG  TODO

Test 6 Récupérer les résultats un job
    [Documentation]  Récupérer les résultats un job. Vérifier les résultats. Vérifier que le job est bien supprimé.
    [Tags]  CommandLine Tests
    LOG  TODO

Test 7 Tester la durée d’exécution
    [Documentation]  Ces tests doivent prouver que la synchronisation scheduler/worker est correcte. Par défaut les messages de synchronisation worker/scheduler se font toutes les 5mn. Au bout de trois messages non reçus par le scheduler, le job est considéré comme perdu et doit être reschédulé.
    [Tags]  CommandLine Tests
    LOG  TODO

Test 8 Tester la perte des jobs
    [Documentation]
    [Tags]  CommandLine Tests
    LOG  TODO

*** Keywords ***

XWSENDAPPCommand
    [Documentation]  Usage :  SENDAPP appName appType cpuType osName URI | UID : inserts/updates an application; URI or UID points to binary file ; application name must be the first parameter
    [Arguments]  ${appName}  ${appType}  ${cpuType}  ${osName}  ${uri-udi}
    ${cmd_result} =  Run Process  cd ${DIST_XWHEP_PATH}/bin && ./xwsendapp ${appName} ${appType} ${cpuType} ${osName} ${uri-udi}  shell=yes
    Log  ${cmd_result.stderr}
    Log  ${cmd_result.stdout}
    Should Be Equal As Integers	${cmd_result.rc}	0
    ${uid} =  Get Substring  ${cmd_result.stdout}  -36
    Log  ${uid}
    [Return]  ${uid}

XWSENDDATACommand
    [Documentation]  Usage :  SENDDATA dataName [cpuType] [osName] [dataType] [accessRigths] [dataFile | dataURI | dataUID] : sends data and uploads data if dataFile provided
    [Arguments]  ${dataName}  ${osName}  ${cpuType}  ${dataType}  ${dataFile-dataURI-dataUID}
    ${cmd_result} =  Run Process  cd ${DIST_XWHEP_PATH}/bin && ./xwsenddata ${dataName} ${osName} ${cpuType} ${dataType} ${dataFile-dataURI-dataUID}  shell=yes
    Log  ${cmd_result.stderr}
    Log  ${cmd_result.stdout}
    Should Be Equal As Integers	${cmd_result.rc}	0
    ${uid} =  Get Substring  ${cmd_result.stdout}  -36
    Log  ${uid}
    [Return]  ${uid}