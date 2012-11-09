-module(factory_tests).
-include_lib("eunit/include/eunit.hrl").

-include("contracts.hrl").
-import(contracts,[format/1]).
-import(factory,[do/2,handle/2]).

-define(ID,"factory/11").

-define(GIVEN(Events),State=lists:foldl(fun(Evt,State) -> handle(State,Evt) end,undefined,Events)).
-define(WHEN(Command),Out=do(State,Command)).
-define(EXPECT(Event),?assertEqual(Out,Event)).

open_factory_test_() -> [
{"Open a new factory",fun() ->
  ?GIVEN([]),
  ?WHEN(#openFactory{id=?ID}),
  ?EXPECT(#factoryOpened{id=?ID})
end},
{"Open a factory that has been opened before",fun() ->
  ?GIVEN([#factoryOpened{id=?ID}]),
  ?WHEN(#openFactory{id=?ID}),
  ?EXPECT(factory_already_created)
end}
].

assign_employee_to_factory_test_() -> [
{"Empty factory allows any employee not Bender to be assigned", fun()->
    ?GIVEN([#factoryOpened{id=?ID}]),
    ?WHEN(#assignEmployeeToFactory{id=?ID,employeeName="fry"}),
    ?EXPECT(#employeeAssignedToFactory{id=?ID,employeeName="fry"})
 end},
{"Duplicate employee name is assigned but not allowed",fun()->
    ?GIVEN([#factoryOpened{id=?ID},
            #employeeAssignedToFactory{id=?ID,employeeName="fry"}]),
    ?WHEN(#assignEmployeeToFactory{id=?ID,employeeName="fry"}),
    ?EXPECT(employee_name_already_taken)
 end},
{"No employee named 'Bender' is allowed to be assigned",fun()->
    ?GIVEN([#factoryOpened{id=?ID}]),
    ?WHEN(#assignEmployeeToFactory{id=?ID,employeeName="Bender"}),
    ?EXPECT(bender_employee)
 end},
{"Can't assign an employee to an unopened factory",fun()->
    ?GIVEN([]),
    ?WHEN(#assignEmployeeToFactory{id=?ID,employeeName="fry"}),
    ?EXPECT(factory_is_not_open)
 end}
].

