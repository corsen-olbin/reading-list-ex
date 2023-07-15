defmodule ReadingListEx.TreeHelper do
  defmodule TreeNode do
    defstruct [:name, children: []]
  end

  defmodule TreeFunctions do
    def create_tree(stringList) do
      create_tree_rec(stringList, [])
    end

    def create_tree_rec(nil, acc), do: acc
    def create_tree_rec([], acc), do: acc

    def create_tree_rec([head | list], acc) do
      new_acc =
        head
        |> String.split(" / ")
        |> add_branch(acc)

      create_tree_rec(list, new_acc)
    end

    def add_branch([], acc), do: acc

    def add_branch([genre | rest], acc) do
      case Enum.find_index(acc, fn %TreeNode{name: x} -> x == genre end) do
        nil ->
          [%TreeNode{name: genre, children: add_branch(rest, [])} | acc]

        index ->
          List.update_at(acc, index, fn %TreeNode{children: under} = tree ->
            %{tree | children: add_branch(rest, under)}
          end)
      end
    end
  end
end
