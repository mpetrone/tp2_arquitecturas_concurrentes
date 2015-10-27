defmodule TP1Test do
  use ExUnit.Case

  test "test" do
    alumno1 = Alumno.start(1)
    alumno2 = Alumno.start(2)
    alumno3 = Alumno.start(3)

    docente1 = Docente.start(1)
    docente2 = Docente.start(2)
    docente3 = Docente.start(3)
    plataforma = Plataforma.start(%{}, %{})
    send plataforma, {:addAlumno, 1, alumno1}
    send plataforma, {:addAlumno, 2, alumno2}
    send plataforma, {:addAlumno, 3, alumno3}

    send plataforma, {:addDocente, 1, docente1}
    send plataforma, {:addDocente, 2, docente2}
    send plataforma, {:addDocente, 3, docente3}

    send plataforma, {:consulta, 1, "hola"}
    send plataforma, {:respuesta, 1, "chau"}
  end
end
