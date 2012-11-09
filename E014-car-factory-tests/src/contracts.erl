-module(contracts).
-include("contracts.hrl").

-export([format/1]).
-define(FORMAT(RecordType,FormatString), 
    format(Rec=#RecordType{}) -> 
      FieldNames=record_info(fields, RecordType),
      Values=tl(tuple_to_list(Rec)),
      PropList=lists:zip(FieldNames,Values),
      subst(FormatString,PropList)
).

?FORMAT(openFactory,"Open Factory(ID='{id}')");
?FORMAT(factoryOpened,"Opened Factory(ID='{id}')");
?FORMAT(assignEmployeeToFactory,"Assign employee '{employeeName}'");
?FORMAT(employeeAssignedToFactory,"new worker joins our forces: '{employeeName}'");
?FORMAT(curseWordUttered,"'{theWord}' was heard within the walls. It meant:\r\n    '{meaning}'");
?FORMAT(unpackAndInventoryShipmentInCargoBay,"Unload the cargo '{employeeName}'");
?FORMAT(produceACar,"Employee '{employeeName}' produce car:{carModel}");
format(X) -> X.

subst(Fmt,[]) -> 
  Fmt;
subst(Fmt,[{_,undefined}|T]) ->
  subst(Fmt,T);
subst(Fmt,[{K,V}|T]) ->
  Replaced = re:replace(Fmt,"\\{" ++ atom_to_list(K) ++ "\\}",[V],[global,{return,list}]),
    subst(Replaced,T).
