-module(contracts_tests).
-include_lib("eunit/include/eunit.hrl").

-include("contracts.hrl").
-import(contracts,[format/1]).

formatting_test_() -> [
  ?_assertEqual(format(#openFactory{id="factory/1"}) 
                ,"Open Factory(ID='factory/1')" ),
  ?_assertEqual(format(#factoryOpened{id="factory/1"})
                ,"Opened Factory(ID='factory/1')"),
  ?_assertEqual(format(#assignEmployeeToFactory{employeeName="Tom"} )
                ,"Assign employee 'Tom'"),
  ?_assertEqual(format(#employeeAssignedToFactory{employeeName="Tom"} )
                ,"new worker joins our forces: 'Tom'"),
  ?_assertEqual(format(#curseWordUttered{theWord="Sh*t",meaning="trouble"})
                ,"'Sh*t' was heard within the walls. It meant:\r\n    'trouble'"),
  ?_assertEqual(format(#unpackAndInventoryShipmentInCargoBay{employeeName="Tom"} )
                ,"Unload the cargo 'Tom'"),
  ?_assertEqual(format(#produceACar{employeeName="Tom",carModel="Ford T"}) 
                ,"Employee 'Tom' produce car:Ford T")
].
