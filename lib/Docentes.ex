defmodule Docentes do
  def start(map) do
    spawn fn -> main(map) end
  end

  def main(map) do
    receive do

      {:post, docenteId, value} ->
          main(Map.put(map, docenteId, value))

      {:get, docenteId, ref} ->
          send ref, {:ok, Map.get(map, docenteId)}
          main(map)

      {:delete, docenteId} ->
          main(Map.delete(map, docenteId))

    end
  end
end
