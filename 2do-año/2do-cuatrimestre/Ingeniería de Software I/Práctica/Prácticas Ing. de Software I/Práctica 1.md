
### Obtención de los requerimientos.
#### Parte I Definiciones. 
> 1) Definir brevemente que es un requerimiento.
> 2) Defina requerimientos funcionales y no funcionales.
> 3) Defina que es un stakeholder.
> 4) Defina las fuentes más importantes para la obtención de información.
> 5) Indique los puntos de vista (de manera genérica) que se pueden reconocer en un proyecto de software.
> 6) Enumere tres problemas de comunicación que pueden existir en la elicitación de requisitos.

1) Un Requerimiento (o requisito) es una característica del sistema o una descripción de algo que el sistema es capaz de hacer con el objeto de satisfacer el propósito del sistema.
2) Requerimiento funcional: alguna feature o funcionalidad del software.
   Requerimiento no funcional: requerimiento que condiciona a todo el software de forma transversal.
3) Cualquier persona o grupo que se verá afectado por el sistema, directa o indirectamente.
4) Documentación: Información existente (puede ser info. reutilizada de un proyecto previo) relevante para los requerimientos del proyecto. 
   Stakeholders.
   Especificaciones de sistemas similares: Observar sistemas que tengan requerimientos o características en común y ver cómo fueron implementados ciertas funcionalidades, etc.
5) Punto de vista de los interactuadores: representan a las personas u otros sistemas que interactúan directamente con el sistema. Pueden influir en los requerimientos del sistema de algún modo.
   Punto de vista indirecto: representan a los stakeholders que no utilizan el sistema ellos mismos pero que influyen en los requerimientos de algún modo.
   Punto de vista del dominio: representan las características y restricciones del dominio que influyen en los requerimientos del sistema.
6) Dificultad para expresar claramente las necesidades.
   No ser conscientes de sus propias necesidades.
   No entender cómo la tecnología puede ayudar.
   Miedo a parecer incompetentes por ignorancia tecnológica.
   No tomar decisiones por no poder prever las consecuencias, no entender las alternativas o no tener una visión global.
   Cultura y vocabulario diferentes.
   Intereses distintos en el sistema a desarrollar.
   Medios de comunicación inadecuados (diagramas que no entienden los clientes y usuarios). Conflictos personales o políticos.

---

#### Parte II Problemas.

a) Indicar para cada problema quienes podrían ser los Stakeholders, los puntos de vista y las fuentes de información.

> 1. En un sistema de registro de asistencia a través de técnicas biométricas (huella digital) de estudiantes universitarios para la cátedra de Ingeniería I. Este sistema se alimentará de un listado otorgado por la oficina de alumnos de la facultad. Además, necesita la autorización del Jefe de Trabajos Prácticos del turno correspondiente para luego los alumnos poder registrar el presente. También, el profesor a cargo de la materia podrá consultar y listar el estado de cada alumno perteneciente a su cátedra. El sistema sólo se utilizará en el ámbito de la facultad de Informática y deberá adecuarse a la reglamentación sobre privacidad de los datos en el ámbito de la misma.

==Stakeholders:== estudiantes universitarios, JTP, profesor titular.
==Puntos de vista:==
- Interactuadores: estudiantes y profesor titular. Interactúan directamente con el sistema.
- Indirectos: JTP. Debe autorizar el presente de los alumnos del respectivo turno, pero no utiliza el sistema.
- Dominio: Reglamentación sobre privacidad de datos. Influye en los requerimientos del sistema.
==Fuente de información:== oficina de alumnos, reglamentación de privacidad de datos de la facultad.

---

> 2. Se desea desarrollar un sistema para gestionar y administrar la atención de pacientes en una clínica privada especializada en tratamientos alérgicos. Cuando un paciente nuevo es ingresado a la clínica el empleado registra todos sus datos personales, posteriormente un enfermero registra los controles y realiza las anotaciones habituales (temperatura, presión, peso, reacciones alérgicas etc.). Luego, el paciente es derivado con alguno de los doctores de la clínica, quién registra qué tratamientos deberá realizar. El médico también se encarga de registrar si el paciente debe quedar internado y debe mantener su historia clínica durante el período que dure el tratamiento. Se sabe que el director de la clínica puede consultar las historias clínicas de todos los pacientes. El sistema debe adecuarse a las normativas impuestas por el ministerio de salud de la provincia de Bs As.

==Stakeholders:== empleados, enfermeros, médicos, director y pacientes. (Pacientes porque el sistema trabaja con sus datos personales).
==Puntos de vista:==
- Interactuadores: empleados, enfermeros, médicos y director.
- Indirectos: Pacientes. No utilizarán el sistema pero influyen indirectamente en el mismo, p. ej. en la protección de sus datos personales.
- Dominio: Normativas del ministerio de salud pcia. Bs. As. Influye en los requerimientos del sistema.
==Fuente de información:== stakeholders, documentación de los mismos.

---

### Entrevistas

#### Parte I Definiciones.
> 1. Describa qué tipo de información puede obtenerse en una entrevista.
> 2. Enumere y describa brevemente las etapas de la preparación de una entrevista.
> 3. Enumere y describa brevemente qué tipos de preguntas puede contener una entrevista. Detalle ventajas y desventajas de cada una.
> 4. Enumere y describa brevemente qué tipo de estructuras y organización existen para el armado de una entrevista.
> 5. Analice un formato de la planilla adecuado al momento de armar una entrevista.
> 6. Analice un formato de la planilla adecuado al momento de terminar una entrevista.

1) Opiniones, objetivos, procedimientos informales, sentimientos.
2) 
   - ==Leer los antecedentes del entrevistado:== se trata de entender a la persona a entrevistar. Lenguaje, vocabulario, contexto.
   - ==Establecer los objetivos de la entrevista:== usando los antecedentes. Definir qué tipo de resultado se espera. Los directivos suelen proporcionar una visión general, mientras que los futuros usuarios una más detallada.
   - ==Seleccionar los entrevistados:== se debe minimizar el número de entrevistas. Hacer un relevamiento que abarque los usuarios más importantes para el sistema. 
   - ==Planificación de la entrevista y preparación del entrevistado:== establecer fecha, hora, lugar y duración de cada entrevista de acuerdo con el entrevistado. Los entrevistados deben conocer con antelación el objetivo de la entrevista y las preguntas que se le van a hacer.
   - ==Selección del tipo de preguntas a usar y su estructura:== se desarrolla en la preg. 3.


3) 
	- ==Abiertas:==