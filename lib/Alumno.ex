defmodule Alumno do
  def start(id, ref) do
    spawn fn -> main(id, ref) end
  end

  def main(id, plataforma) do
    receive do

      {:escribirConsulta, descripcion} ->
        send plataforma, {:consulta, id, descripcion}
        main(id, plataforma)

      {:recibirConsulta, idConsulta, remitente, descripcion} ->
        IO.puts "Alumno #{id}:Me llego la consulta #{idConsulta} con descripcion #{descripcion}"
        main(id, plataforma)

      {:recibirRespuesta, idConsulta, descripcion} ->
        IO.puts "Alumno #{id}:Me llego la respuesta #{idConsulta} con descripcion #{descripcion}"
        main(id, plataforma)

    end
  end
end
