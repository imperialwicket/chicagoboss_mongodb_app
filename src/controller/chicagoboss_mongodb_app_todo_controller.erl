-module(chicagoboss_mongodb_app_todo_controller, [Req]).
-compile(export_all).

list('GET', []) ->
    Todos = boss_db:find(mo_todo, []),
    {ok, [{todos, Todos}]};

list('POST', []) ->
    Todo = mo_todo:new(id, Req:post_param("todo"), erlang:now()),
    Create = Todo:save(),
    case Create of
        {ok, NewTodo} ->
            {ok, []};
        {error, [ErrorMessages]} ->
            {ok, [{errors, ErrorMessages}]}
    end.
