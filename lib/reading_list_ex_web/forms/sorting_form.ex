defmodule ReadingListExWeb.Forms.SortingForm do
  import Ecto.Changeset

  alias ReadingListEx.EctoHelper

  @fields %{
    sort_by: EctoHelper.enum([:title, :authors, :status]),
    sort_dir: EctoHelper.enum([:asc, :desc])
  }

  @default_values %{
    sort_by: :status,
    sort_dir: :asc
  }

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def default_values(), do: @default_values
end
