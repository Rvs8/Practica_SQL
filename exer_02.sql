-- Tabla alumnos
CREATE TABLE alumnos (
    alumno_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    ciudad VARCHAR(50),
    pais VARCHAR(50)
);

-- Tabla profesores
CREATE TABLE profesores (
    professor_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    ciudad VARCHAR(50),
    pais VARCHAR(50)
);

-- Tabla bootcamps (sin FKs cruzadas aún)
CREATE TABLE bootcamps (
    bootcamp_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

-- Tabla modulos
CREATE TABLE modulos (
    modulo_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion_horas INTEGER
);

-- Tabla recursos
CREATE TABLE recursos (
    recurso_id SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    titulo VARCHAR(50),
    descripcion TEXT,
    url TEXT,
    fecha_subida DATE NOT NULL,
    autor VARCHAR(50),
    modulo_id INTEGER REFERENCES modulos(modulo_id)
);

-- Tabla inscripcion
CREATE TABLE inscripcion (
    inscripción_id SERIAL PRIMARY KEY,
    alumno_id  INTEGER REFERENCES alumnos(alumno_id),
    bootcamp_id INTEGER REFERENCES bootcamps(bootcamp_id),
    fecha_inscripcion DATE NOT NULL,
    estado VARCHAR(50)
);

-- Tabla pagos
CREATE TABLE pagos (
    pago_id SERIAL PRIMARY KEY,
    inscripción_id INTEGER REFERENCES inscripcion(inscripción_id),
    fecha_pago DATE NOT NULL,
    metodo_pago VARCHAR(50),
    referencia VARCHAR(50)
);

-- Tabla evaluacion
CREATE TABLE evaluacion (
    evaluación_id SERIAL PRIMARY KEY,
    alumno_id INTEGER REFERENCES alumnos(alumno_id),
    modulo_id INTEGER REFERENCES modulos(modulo_id),
    fecha DATE,
    tipo VARCHAR(50),
    nota NUMERIC(4,2),
    observaciones TEXT,
    estado VARCHAR(50)
);

-- Añadir FKs cruzadas después
ALTER TABLE bootcamps
ADD COLUMN alumno_id INTEGER REFERENCES alumnos(alumno_id),
ADD COLUMN profesor_id INTEGER REFERENCES profesores(profesor_id),
ADD COLUMN modulo_id INTEGER REFERENCES modulos(modulo_id);

ALTER TABLE modulos
ADD COLUMN bootcamp_id INTEGER REFERENCES bootcamps(bootcamp_id),
ADD COLUMN profesor_id INTEGER REFERENCES profesores(profesor_id);

ALTER TABLE profesores
ADD COLUMN modulo_id INTEGER REFERENCES modulos(modulo_id);






