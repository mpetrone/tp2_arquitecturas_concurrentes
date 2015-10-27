defmodule Plataforma do
  def start(alumnos, docentes) do
    spawn fn -> main(alumnos, docentes) end
  end

  def main(alumnos, docentes) do
    receive do

      {:addAlumno, alumnoId, ref} ->
          IO.puts "Agregue al alumno #{alumnoId}" 
          main(Map.put(alumnos, alumnoId, ref), docentes)

      {:addDocente, docenteId, ref} ->
          IO.puts "Agregue al docente #{docenteId}" 
          main(alumnos, Map.put(docentes, docenteId, ref))

      {:consulta, remitente, descripcion} ->
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirConsulta, remitente, descripcion} end)
          Enum.map(docentes, fn{k, ref} -> send ref, {:recibirConsulta, remitente, descripcion} end)
          main(alumnos, docentes)

      {:respuesta, docenteId, descripcion} ->
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirRespuesta, descripcion} end)
          Enum.map(docentes, fn{k, ref} -> send ref, {:recibirRespuesta, descripcion} end)
          main(alumnos, docentes)

    end
  end
end