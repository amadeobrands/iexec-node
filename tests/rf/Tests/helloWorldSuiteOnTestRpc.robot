*** Settings ***
Documentation    End-to-End test HelloWorld usacase Oracle+bridge+xtremweb
Resource  ../Resources/XWCommon.robot
Resource  ../Resources/XWServer.robot
Resource  ../Resources/IexecOracle.robot
Resource  ../Resources/ETHTestrpc.robot
Resource  ../Resources/cli/XWClient.robot
Resource  ../Resources/smartcontracts/HelloWorldSmartContract.robot
Resource  ../Resources/smartcontracts/IexceOracleSmartContract.robot
Suite Setup  Start Oracle Bridge And Xtremweb
Suite Teardown  Stop Oracle Bridge And Xtremweb


# to launch tests : pybot -d Results ./Tests/helloWorldSuiteOnTestRpc.robot
# Quicker for second launch :
# pybot --variable XW_FORCE_GIT_CLONE:false --variable IEXEC_ORACLE_FORCE_GIT_CLONE:false -d Results ./Tests/helloWorldSuiteOnTestRpc.robot

*** Variables ***
${USER}
${CREATOR}


*** Test Cases ***

Test HelloWorld Iexec
    [Documentation]  Test HelloWorld Iexec
    [Tags]  HelloWorld Tests
    ${user} =  IexceOracleSmartContract.Get User Address
    Set Suite Variable  ${USER}  ${user}
    ${creator} =  IexceOracleSmartContract.Get Creator Address
    Set Suite Variable  ${CREATOR}  ${creator}
    ${app_uid} =  XWClient.XWSENDAPPCommand  echo  DEPLOYABLE  LINUX  AMD64  /bin/echo
    XWServer.Count From Apps Where Uid  ${app_uid}  1
    HelloWorldSmartContract.Call RegisterEcho
    Check Register Launch Event In IexceOracleSmartContract
    ${work_uid} =  Check Register CallbackEvent Event In IexceOracleSmartContract
    LOG  ${work_uid}
    #IexecOracle.Get Bridge Log

    #uid: '07ba27ae-45b2-43c8-902d-a7099f0cf347'



    # ???? Failed :  XWServer.Count From Works Where Uid  @{work_uid}[0]  1
    # ???? Failed : XWClient.Check XWSTATUS Pending  xw://vagrant-ubuntu-trusty-64/@{work_uid}[0]


    #get work


    #Sleep  1 minutes
    # check stats with workuid
    #IexecOracle.Get Bridge Log
    #XWClient.XWWORKSCommand
    #Sleep  2 minutes
    #IexecOracle.Get Bridge Log
    #XWClient.XWWORKSCommand


*** Keywords ***

Check Register Launch Event In IexceOracleSmartContract
    ${watch_launch_event} =  Wait Until Keyword Succeeds  1 min	10 sec  IexceOracleSmartContract.Watch LaunchEvent
    Should Contain  ${watch_launch_event}  functionName: 'register'
    Should Contain  ${watch_launch_event}  param1: 'echo'
    Should Contain  ${watch_launch_event}  user: '${USER}'
    Should Contain  ${watch_launch_event}  creator: '${CREATOR}'
    Should Contain  ${watch_launch_event}  provider: '${HELLO_WORLD_SM_ADDRESS}'

Check Register CallbackEvent Event In IexceOracleSmartContract
    ${watch_callback_event} =  Wait Until Keyword Succeeds  1 min	10 sec  IexceOracleSmartContract.Watch CallbackEvent
    Should Contain  ${watch_callback_event}  callbackType: 'RegisterCallback'
    Should Contain  ${watch_callback_event}  appName: 'echo'
    Should Contain  ${watch_callback_event}  user: '${USER}'
    Should Contain  ${watch_callback_event}  creator: '${CREATOR}'
    Should Contain  ${watch_callback_event}  provider: '${HELLO_WORLD_SM_ADDRESS}'
    @{work_uid} =  Get Regexp Matches  ${watch_callback_event}  uid: '(?P<work_uid>.*)',  work_uid
    [Return]  @{work_uid}[0]


Start Oracle Bridge And Xtremweb
    XWCommon.Prepare And Start XWtremWeb Server And XWtremWeb Worker
    ETHTestrpc.Start Testrpc
    IexecOracle.Iexec Oracle Truffle Migrate
    IexecOracle.Iexec Oracle Set Contract Address In Bridge
    IexecOracle.Iexec Oracle Set XtremWeb Config In Bridge
    IexecOracle.Start Bridge


Stop Oracle Bridge And Xtremweb
    IexecOracle.Stop Bridge
    ETHTestrpc.Stop Testrpc
    XWCommon.Stop XWtremWeb Server And XWtremWeb Worker
