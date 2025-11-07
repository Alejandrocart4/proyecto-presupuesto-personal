# Sistema de Presupuesto Personal

## Descripción del Proyecto
El Sistema de Presupuesto Personal es una aplicación diseñada para ayudar a los usuarios a gestionar sus finanzas personales de forma estructurada y automatizada. Permite crear presupuestos, registrar ingresos y gastos, definir metas de ahorro y recibir alertas financieras. El sistema centraliza la información económica mensual y anual de cada usuario, facilitando el control del dinero y la toma de decisiones financieras.

## Objetivo General
Desarrollar un sistema que permita a los usuarios planificar, registrar y monitorear su presupuesto personal, automatizando el cálculo de ingresos, gastos y ahorros mensuales.

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
| alerta | Registra las notificaciones automáticas generadas por el sistema. |

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

## Tecnologías Sugeridas
- Modelado: Draw.io / dbdiagram.io
- Base de datos: MySQL / PostgreSQL
- Lenguaje de programación: C++ o Python (según implementación final)
- Interfaz de usuario: Qt / Web (según alcance del proyecto)

## Autor
**Nombre:** Jonny Gómez  
**Carrera:** Ingeniería en Sistemas Computacionales  
**Institución:** UNITEC Honduras  
**Materia:** Estructura de Datos I / Proyecto Integrador  
**Año:** 2025
