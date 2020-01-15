program Lab2_3;

const
  v = 9; {Graph vertices count }
  inf = 1000;
type
  TGraph = array [1..v, 1..v] of integer;
var
  a, b, top : integer;
  graph : TGraph; {array defining the adjacency matrix of graphs}


procedure CreateGraph (var graph : TGraph); {Create the graph}
begin
  writeln('Please enter the weight of graph arc. If there is no arc between graph vertices, then enter 0');
  for a := 1 to v do
    for b := 1 to v do
    begin
      write('Arc that connects ', a, ' and ', b, ' = ');
      readln(graph[a, b]);
      if graph[a, b] < 0 then
      begin
        Writeln('The arc weight can not be negative, please enter the value >=0');
        exit;
      end;
    end;
end;

procedure PrintGraph(graph : TGraph);
var
  i, n : integer;
begin
  for i := 1 to v do
  begin
    for n := 1 to v do
      write(graph[i, n]: 3);
    writeln;
  end;

end;

procedure Path(graph : TGraph; top : integer);
var
  count, index, i, u, min : integer;
  distance : array [1..v] of integer;
  visited : array [1..v] of boolean;
begin
  for i := 1 to v do
  begin
    distance[i] := inf;
    visited[i] := false;
  end;
  distance[top] := 0;
  for count := 1 to v - 1 do
  begin
    min := inf;
    for i := 1 to v do
      if (not visited[i]) and (distance[i] <= min) then
      begin
        min := distance[i];
        index := i;
      end;
    u := index;
    visited[u] := true;
    for i := 1 to v do
      if (not visited[i]) and (graph[u, i] <> 0) and (distance[u] <> inf) and
      (distance[u] + graph[u, i] < distance[i]) then
        distance[i] := distance[u] + graph[u, i];
  end;
  
  writeln('The cost of the shortest path from the initial vertex to the rest:');
  
  for i := 1 to v do
    if distance[i] <> inf then
      writeln('   ', top, ' -> ', i, ' = ', distance[i])
    else
      writeln('   ', top, ' -> ', i, ' no path');
end;

procedure short(var graph : TGraph; v : integer);
var
  i, n, m : integer;
begin
  for i := 1 to v do
    graph[i, i] := 0;
  for m := 1 to v do
    for i := 1 to v do
      for n := 1 to v do
        if (graph[i, m] <> 0) and (graph[m, n] <> 0) and (i <> n) then
          if (graph[i, m] + graph[m, n] < graph[i, n]) or (graph[i, n] = 0) then
            graph[i, n] := graph[i, m] + graph[m, n];
end;

begin
  CreateGraph(graph); {Enter graph elements}
  if graph[a, b] < 0 then exit;    {if arc has negative weight then exit}

  writeln('The adjacency matrix of the introduced graph:');
  PrintGraph(graph);

  write('Enter the number of graph top');

  readln(top);
  Path(graph, top);

  writeln('The matrix of the shortest distances between pairs of vertices:');

  short(graph, v);
  PrintGraph(graph);
  readln;
end.
