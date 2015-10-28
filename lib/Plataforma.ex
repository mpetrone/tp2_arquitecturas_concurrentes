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
          idConsulta = :random.uniform 100000
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirConsulta, idConsulta, remitente, descripcion} end)
          Enum.map(docentes, fn{k, ref} -> send ref, {:recibirConsulta, idConsulta, remitente, descripcion} end)
          main(alumnos, docentes)

     {:empezarRespuesta, idConsulta, remitente} ->
          Enum.map(docentes, fn{k, ref} -> send ref, {:empezaronRespuesta, idConsulta} end)
          main(alumnos, docentes)

      {:finalizarRespuesta, idConsulta, remitente, descripcion} ->
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirRespuesta, idConsulta, descripcion} end)
          Enum.map(docentes, fn{k, ref} -> send ref, {:recibirRespuesta, idConsulta, descripcion} end)
          main(alumnos, docentes)

    end
  end
end