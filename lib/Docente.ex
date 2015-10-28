defmodule Docente do
  def start(id, ref) do
    spawn fn -> main(id, ref) end
  end

  def main(id, plataforma) do
    receive do

      {:recibirConsulta, idConsulta, remitente, descripcion} ->
        IO.puts "Docente #{id}: Me llego la consulta #{idConsulta} con descripcion #{descripcion}"
        main(id, plataforma)

      {:recibirRespuesta, idConsulta, descripcion} ->
        IO.puts "Docente #{id}: Me llego la respuesta de #{idConsulta} con descripcion #{descripcion}"
        main(id, plataforma)

      {:empezaronRespuesta, idConsulta} ->
        IO.puts "Docente #{id}: Me llego que empezaron la respuesta de #{idConsulta}"
        main(id, plataforma)



     {:empezarRespuesta, idConsulta} ->
        send plataforma, {:empezarRespuesta, idConsulta, id}
        main(id, plataforma)

      {:finalizarRespuesta, idConsulta, descripcion} ->
        send plataforma, {:finalizarRespuesta, idConsulta, id, descripcion}
        main(id, plataforma)

    end
  end
end
