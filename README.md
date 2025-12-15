#  Sistema de Presupuesto Personal – Backend en Consola con Node.js

El Sistema de Presupuesto Personal es una aplicación backend desarrollada para ejecutarse completamente desde la consola, cuyo propósito es permitir la gestión integral de finanzas personales mediante el control de usuarios, categorías, presupuestos, transacciones, metas de ahorro y alertas automáticas. El proyecto fue desarrollado utilizando Node.js como capa de aplicación y MariaDB como motor de base de datos, delegando la mayor parte de la lógica de negocio a procedimientos almacenados, funciones y triggers, siguiendo buenas prácticas de diseño de sistemas de bases de datos.

El objetivo principal del proyecto es aplicar de forma práctica los conocimientos adquiridos en la asignatura de Fundamentos de Sistemas de Bases de Datos, incluyendo el diseño de un modelo relacional normalizado hasta Tercera Forma Normal (3FN), la implementación de reglas de negocio a nivel de base de datos, el uso de procedimientos almacenados para operaciones CRUD y lógica compleja, y la integración de estos elementos con una aplicación en Node.js ejecutada desde la línea de comandos.

El sistema sigue una arquitectura de tres capas. La capa de presentación corresponde a una interfaz de consola implementada en Node.js, la cual muestra menús interactivos y captura la entrada del usuario. La capa de negocio está representada por el backend en Node.js, cuya responsabilidad principal es validar entradas básicas, organizar la navegación por menús e invocar procedimientos almacenados en la base de datos. La capa de datos está compuesta por MariaDB, donde se implementa la lógica principal del sistema mediante tablas normalizadas, procedimientos almacenados, funciones SQL y triggers automáticos.

Las tecnologías utilizadas en el proyecto incluyen Node.js con JavaScript moderno (ES Modules) para la aplicación de consola, MariaDB como motor de base de datos relacional, DBeaver como herramienta de administración de la base de datos y Git para el control de versiones. El proyecto se ejecuta desde la terminal o PowerShell y no requiere interfaz gráfica.

La estructura del proyecto se organiza en módulos claramente definidos. El directorio de consola contiene el punto de entrada de la aplicación y los distintos menús funcionales, como gestión de usuarios, categorías, presupuestos, transacciones, metas y reportes. El módulo de conexión a base de datos centraliza la configuración y el acceso a MariaDB. Los archivos utilitarios se encargan de la entrada y salida de datos en consola. Adicionalmente, se incluye una carpeta dedicada a la base de datos que contiene los scripts DDL, procedimientos almacenados, funciones, triggers y datos de prueba.

Desde la consola, el sistema permite gestionar usuarios, incluyendo la creación, actualización, consulta, listado y desactivación lógica. También permite la administración de categorías y subcategorías para ingresos, gastos y ahorros, garantizando mediante triggers que toda categoría tenga al menos una subcategoría por defecto. El módulo de presupuestos permite crear planes financieros con vigencia definida, asignar montos mensuales por subcategoría, consultar presupuestos activos y cerrarlos al finalizar su período.

El sistema permite registrar transacciones de ingreso, gasto y ahorro, asociándolas a presupuestos y subcategorías específicas. Los campos de año y mes presupuestal son independientes de la fecha real de la transacción, lo que permite flexibilidad contable. Las validaciones de vigencia, tipo de transacción y coherencia de datos se realizan mediante procedimientos almacenados. Al registrar transacciones, el sistema genera automáticamente alertas cuando se alcanzan o superan ciertos porcentajes del presupuesto mensual.

El módulo de metas de ahorro permite crear objetivos financieros asociados a subcategorías de tipo ahorro. El avance de cada meta se actualiza automáticamente mediante triggers al registrar transacciones de ahorro, y el sistema cambia el estado de la meta cuando se alcanza el monto objetivo. Asimismo, se generan alertas informativas al alcanzar porcentajes relevantes de avance.

El sistema incluye un módulo de alertas que notifica eventos importantes como ejecución presupuestal alta, exceso de presupuesto y progreso de metas de ahorro. Las alertas se generan automáticamente en la base de datos y pueden ser consultadas desde la consola. Adicionalmente, se dispone de reportes básicos en consola, como el balance mensual y el resumen de ingresos, gastos y ahorros, los cuales se obtienen invocando procedimientos almacenados de consulta.

Una característica fundamental del proyecto es que la lógica de negocio se encuentra centralizada en la base de datos. El backend en Node.js no realiza cálculos financieros complejos, sino que se limita a invocar procedimientos almacenados, lo que garantiza consistencia, reutilización y facilidad de mantenimiento. Las reglas de negocio, validaciones, cálculos y automatizaciones se implementan en SQL mediante procedimientos, funciones y triggers.

Para ejecutar el proyecto es necesario contar con Node.js y MariaDB instalados, así como haber ejecutado previamente todos los scripts de creación de la base de datos, procedimientos almacenados, funciones, triggers y datos de prueba. Una vez instaladas las dependencias con npm, la aplicación se ejecuta desde la consola utilizando el comando node consola/index.js, lo que inicia el menú principal interactivo.

El proyecto incluye datos de prueba realistas que simulan la actividad financiera de dos meses completos, con categorías, presupuestos, transacciones, metas y alertas generadas automáticamente, permitiendo demostrar el correcto funcionamiento del sistema.

El Sistema de Presupuesto Personal se encuentra completamente finalizado y funcional en su versión de consola. Este proyecto evidencia el dominio de conceptos fundamentales de bases de datos, el uso correcto de procedimientos almacenados y triggers, y la integración efectiva de una aplicación backend en Node.js con un motor de base de datos relacional, cumpliendo con los objetivos académicos planteados y estando listo para su defensa y demostración.
## Funcionalidades Principales
- Registro de usuarios con información básica y salario mensual.
- Creación de presupuestos con períodos definidos (año y mes).
- Clasificación de gastos e ingresos mediante categorías y subcategorías.
- Registro de obligaciones fijas (pagos recurrentes como alquiler o servicios).
- Registro de transacciones (ingresos, gastos o ahorros).
- Creación de metas de ahorro asociadas a subcategorías.
- Generación de alertas automáticas por vencimientos o desviaciones del presupuesto.
- Cálculo automático de totales y porcentajes ejecutados.
- Control de auditoría (registro de quién crea o modifica cada registro).

## Modelo de Datos
| Entidad | Descripción |
|----------|-------------|
| usuario | Contiene la información personal y financiera del usuario. |
| presupuesto | Registra el plan financiero de un usuario durante un periodo definido. |
| categoria | Agrupa los tipos generales de ingresos o gastos. |
| subcategoria | Detalla las divisiones específicas dentro de una categoría. |
| presupuesto_detalle | Relaciona un presupuesto con las subcategorías que lo componen. |
| obligacion_fija | Representa gastos recurrentes del usuario. |
| transaccion | Guarda los movimientos financieros reales del usuario. |
| meta_ahorro | Define metas financieras que el usuario desea alcanzar. |


## Relaciones Principales
- Un usuario puede tener varios presupuestos, obligaciones fijas, transacciones, metas de ahorro y alertas.
- Cada presupuesto está asociado a un solo usuario, pero puede contener múltiples subcategorías.
- Cada subcategoría pertenece a una categoría y puede estar relacionada con transacciones, metas y obligaciones fijas.
- Las alertas se pueden generar tanto por obligaciones fijas como por detalles de presupuesto.

## Normalización
El modelo está normalizado hasta la **Tercera Forma Normal (3FN)**:
1. **Primera Forma Normal (1FN):** Todos los atributos son atómicos.
2. **Segunda Forma Normal (2FN):** Todos los atributos dependen completamente de la clave primaria.
3. **Tercera Forma Normal (3FN):** No existen dependencias transitivas entre atributos no clave.

## Campos de Auditoría
| Campo | Descripción |
|--------|-------------|
| creado_por | Usuario o proceso que creó el registro. |
| fecha_creacion | Fecha y hora de creación. |
| modificado_por | Usuario o proceso que realizó la última modificación. |
| fecha_modificacion | Fecha y hora de la última modificación. |


## Autor
**Nombre:** Jonny Alejandro Gómez Cartagena  
**Carrera:** Ingeniería en Sistemas Computacionales  
**Institución:** UNITEC SPS Honduras  
**Materia:** Estructura de Datos I / Proyecto Integrador  
**Año:** 2025
