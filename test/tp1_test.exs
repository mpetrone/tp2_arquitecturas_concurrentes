defmodule TP1Test do
  use ExUnit.Case

  test "test" do
    alumno1 = Alumno.start()
    alumno2 = Alumno.start()
    alumno3 = Alumno.start()
    plataforma = Plataforma.start(%{})
    send plataforma, {:addAlumno, 1, alumno1}
    send plataforma, {:addAlumno, 2, alumno2}
    send plataforma, {:addAlumno, 3, alumno3}

    send plataforma, {:consulta, 1, "hola"}
    send plataforma, {:respuesta, 1, "hola"}
  end
end
