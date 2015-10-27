defmodule Alumno do
  def start() do
    spawn fn -> main() end
  end

  def main() do
    receive do
      {:recibirConsulta, remitente, descripcion} ->
        IO.puts "Me llego la consulta " <> descripcion
        main()

      {:recibirRespuesta, descripcion} ->
        IO.puts "Me llego la respuesta " <> descripcion
        main()

    end
  end
end
