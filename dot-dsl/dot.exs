defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end
#http://memesvault.com/wp-content/uploads/I-Have-No-Idea-What-Im-Doing-Dog-02.jpg
defmodule Dot do
  defmacro graph(ast) do
    ast |> parse_ast |> Macro.escape
  end

  def parse_ast([do: ast]), do: parse_ast(ast, %Graph{})
  def parse_ast(nil, graph), do: graph

  def parse_ast({:__block__, _, []}, graph), do: graph
  def parse_ast({:__block__, _, [h | t]}, graph) do
    parse_ast({:__block__, [], t}, parse_ast(h, graph))
  end

  def parse_ast({:graph, _, [[]]}, graph ), do: update_attrs(graph, [])
  def parse_ast({:graph, _, nil}, graph ), do: update_attrs(graph, [])
  def parse_ast({:graph, _, [[{key, val}]]}, graph ), do: update_attrs(graph, [{key, val}])

  def parse_ast({var, _, nil}, graph), do: update_nodes(graph, var, [])
  def parse_ast({var, _, [[]]}, graph), do: update_nodes(graph, var, [])
  def parse_ast({var, _, [[{key, val}]]}, graph), do: update_nodes(graph, var, [{key, val}])


  def parse_ast({:--, _, [{var1, _, _}, {var2, _, nil}]}, graph) do
    update_edges(graph, var1, var2, [])
  end
  def parse_ast({:--, _, [{var1, _, _}, {var2, _, [[]] }]}, graph) do
    update_edges(graph, var1, var2, [])
  end
  def parse_ast({:--, _, [{var1, _, _}, {var2, _, [[{key, val}]] }]}, graph) do
    update_edges(graph, var1, var2, [{key, val}])
  end

  def parse_ast(_, _), do: raise ArgumentError

  defp update_nodes(graph, var, key) do
    Map.update(graph, :nodes, [{var, key}], fn x ->
      (Enum.sort [{var, key}] ++ x) end)
  end

  defp update_edges(graph, var1, var2, key) do
    Map.update(graph, :edges, [{var1, var2, key}], fn x ->
      (Enum.sort [{var1, var2, key}] ++ x)
    end)
  end

  defp update_attrs(graph, attr) do
    Map.update(graph, :attrs, attr, fn x ->
      Enum.sort(attr ++ x)
    end)
  end

end
