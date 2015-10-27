defmodule Docente do
  def start(id) do
    spawn fn -> main(id) end
  end

  def main(id) do
    receive do
      {:recibirConsulta, remitente, descripcion} ->
        IO.puts "Docente #{id}: Me llego la consulta #{descripcion}"
        main(id)

      {:recibirRespuesta, descripcion} ->
        IO.puts "Docente #{id}: Me llego la respuesta #{descripcion}"
        main(id)

    end
  end
end
