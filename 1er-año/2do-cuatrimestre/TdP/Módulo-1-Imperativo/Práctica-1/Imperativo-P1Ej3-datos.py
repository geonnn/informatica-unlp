import random

def generar_datos(num_peliculas):
  for i in range(num_peliculas):
    codigo_pelicula = i + 1
    codigo_genero = random.randint(1, 8)
    puntaje = round(random.uniform(1, 10), 1)
    print(codigo_pelicula)
    print(codigo_genero)
    print(puntaje)
  print("-1")

generar_datos(20)