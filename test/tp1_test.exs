defmodule TP1Test do
  use ExUnit.Case

  test "test" do
    plataforma = Plataforma.start()
    alumno1 = Alumno.start(1, plataforma)
    alumno2 = Alumno.start(2, plataforma)
    alumno3 = Alumno.start(3, plataforma)

    docente1 = Docente.start(1, plataforma)
    docente2 = Docente.start(2, plataforma)
    docente3 = Docente.start(3, plataforma)
    
    send plataforma, {:addAlumno, 1, alumno1}
    send plataforma, {:addAlumno, 2, alumno2}
    send plataforma, {:addAlumno, 3, alumno3}

    send plataforma, {:addDocente, 1, docente1}
    send plataforma, {:addDocente, 2, docente2}
    send plataforma, {:addDocente, 3, docente3}

    send alumno1, {:escribirConsulta, "hola"}
    send docente1, {:empezarRespuesta, 1}
    send docente1, {:finalizarRespuesta, 1, "hola"}
    
  end
end
