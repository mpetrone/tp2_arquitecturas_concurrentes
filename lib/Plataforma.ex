defmodule Plataforma do
  def start() do
    spawn fn -> main(%{}, %{}, %{}) end
  end

  def main(alumnos, docentes, consultas) do
    receive do

      {:addAlumno, alumnoId, ref} ->
          IO.puts "Agregue al alumno #{alumnoId}" 
          main(Map.put(alumnos, alumnoId, ref), docentes, consultas)

      {:addDocente, docenteId, ref} ->
          IO.puts "Agregue al docente #{docenteId}" 
          main(alumnos, Map.put(docentes, docenteId, ref), consultas)

      {:consulta, remitente, descripcion} ->
          idConsulta = :random.uniform 100000
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirConsulta, idConsulta, remitente, descripcion} end)
          Enum.map(docentes, fn{k, ref} -> send ref, {:recibirConsulta, idConsulta, remitente, descripcion} end)
          main(alumnos, docentes, Map.put(consultas, idConsulta, descripcion))

     {:empezarRespuesta, idConsulta, remitente} ->
          Enum.map(docentes, fn{k, ref} -> send ref, {:empezaronRespuesta, idConsulta} end)
          main(alumnos, docentes, consultas)

      {:finalizarRespuesta, idConsulta, remitente, descripcion} ->
          Enum.map(alumnos, fn{k, ref} -> send ref, {:recibirRespuesta, idConsulta, descripcion} end)
          Enum.map(docentes, fn{k, ref} -> send ref, {:recibirRespuesta, idConsulta, descripcion} end)
          main(alumnos, docentes, consultas)

    end
  end
end