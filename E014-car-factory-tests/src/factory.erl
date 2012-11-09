-module(factory).
-record(factory,{id,employees}).
-include("contracts.hrl").
-export([do/2,handle/2]).


do(#factory{id=Id},#assignEmployeeToFactory{id=Id,employeeName="Bender"}) ->
  bender_employee;

do(#factory{id=Id,employees=Employees},#assignEmployeeToFactory{id=Id,employeeName=Name}) ->
  case lists:member(Name,Employees) of
    true  -> employee_name_already_taken;
    false -> #employeeAssignedToFactory{id=Id,employeeName=Name}
  end;

do(undefined,#openFactory{id=Id}) ->
  #factoryOpened{id=Id};

do(#factory{id=_Id},#openFactory{id=_Id}) ->
  factory_already_created;

do(undefined,_) ->
  factory_is_not_open.

handle(undefined, #factoryOpened{id=Id}) ->
  #factory{id=Id,employees=[]};

handle(Fact=#factory{id=Id,employees=Employees},#employeeAssignedToFactory{id=Id,employeeName=Name}) ->
  Fact#factory{employees = [Name|Employees]}.
