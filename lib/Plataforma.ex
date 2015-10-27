defmodule Plataforma do
  def start(alumnos) do
    spawn fn -> main(alumnos) end
  end

  def main(alumnos) do
    receive do

      {:addAlumno, alumnoId, ref} ->
          IO.puts "Agregue al alumno #{alumnoId}" 
          main(Map.put(alumnos, alumnoId, ref))

      {:consulta, remitente, descripcion} ->
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirConsulta, remitente, descripcion} end)
          main(alumnos)

      {:respuesta, docenteId, descripcion} ->
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirRespuesta, descripcion} end)
          main(alumnos)

    end
  end
end