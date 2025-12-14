INSERT INTO usuario (
    primer_nombre,
    segundo_nombre,
    primer_apellido,
    segundo_apellido,
    correo,
    fecha_registro,
    salario_mensual_base,
    estado,
    creado_por,
    creado_en
) VALUES (
    'Alejandro',
    'José',
    'Gómez',
    'Martínez',
    'alejandro@gmail.com',
    NOW(),
    15000,
    'activo',
    'system',
    NOW()
);

INSERT INTO categoria (
    nombre_categoria,
    descripcion_categoria,
    tipo_categoria,
    nombre_iconoui_categoria,
    colorhexa_categoria,
    orden,
    creado_por,
    creado_en
) VALUES
('Salario', 'Ingresos mensuales', 'ingreso', 'money', '#2ECC71', 1, 'system', NOW()),
('Alimentación', 'Gastos de comida', 'gasto', 'food', '#E67E22', 2, 'system', NOW()),
('Servicios', 'Servicios básicos del hogar', 'gasto', 'services', '#3498DB', 3, 'system', NOW()),
('Transporte', 'Gastos de transporte', 'gasto', 'transport', '#1ABC9C', 4, 'system', NOW()),
('Ahorro', 'Metas y fondos de ahorro', 'ahorro', 'savings', '#9B59B6', 5, 'system', NOW());

INSERT INTO subcategoria (
    id_categoria,
    nombre_subcategoria,
    estado,
    auto,
    creado_por,
    creado_en
) VALUES
(33, 'Supermercado', 'activo', 0, 'system', NOW()),
(33, 'Restaurantes', 'activo', 0, 'system', NOW()),
(34, 'Energía eléctrica', 'activo', 0, 'system', NOW()),
(34, 'Agua potable', 'activo', 0, 'system', NOW()),
(36, 'Fondo de emergencia', 'activo', 0, 'system', NOW());

INSERT INTO presupuesto (
    id_usuario,
    nombre_presupuesto,
    anio_inicio,
    mes_inicio,
    anio_fin,
    mes_fin,
    total_ingresos,
    total_gastos,
    total_ahorro,
    fecha_hora_creacion,
    estado,
    creado_por,
    creado_en
) VALUES
(
    1,
    'Presupuesto Enero 2025',
    2025,
    1,
    2025,
    1,
    15000,
    0,
    0,
    NOW(),
    'activo',
    'system',
    NOW()
),
(
    1,
    'Presupuesto Febrero 2025',
    2025,
    2,
    2025,
    2,
    15000,
    0,
    0,
    NOW(),
    'activo',
    'system',
    NOW()
);

INSERT INTO presupuesto_detalle (
    id_presupuesto,
    id_subcategoria,
    monto_mensual,
    observacion,
    creado_por,
    creado_en
) VALUES
-- Presupuesto Enero
(1, 24, 4000, 'Supermercado mensual', 'system', NOW()),
(1, 25, 2000, 'Comidas fuera', 'system', NOW()),
(1, 26, 800,  'Pago energía eléctrica', 'system', NOW()),

-- Presupuesto Febrero
(2, 24, 4000, 'Supermercado mensual', 'system', NOW()),
(2, 25, 2000, 'Comidas fuera', 'system', NOW());

INSERT INTO obligacion_fija (
    id_usuario,
    id_subcategoria,
    nombre_obligacion,
    descripcion,
    monto_fijo_mensual,
    dia_vencimiento,
    estado,
    fecha_inicio,
    creado_por,
    creado_en
) VALUES
(
    1,
    26,
    'Pago energía eléctrica',
    'Factura mensual de energía eléctrica',
    800,
    15,
    'activo',
    '2025-01-01',
    'system',
    NOW()
),
(
    1,
    27,
    'Pago agua potable',
    'Factura mensual de agua',
    300,
    20,
    'activo',
    '2025-01-01',
    'system',
    NOW()
);

INSERT INTO meta_ahorro (
    id_usuario,
    id_subcategoria,
    nombre,
    descripcion,
    monto_total,
    monto_ahorrado,
    fecha_inicio,
    fecha_objetivo,
    prioridad,
    estado,
    creado_por,
    creado_en
) VALUES (
    1,
    28,
    'Fondo de Emergencia',
    'Ahorro destinado a imprevistos',
    20000,
    0,
    '2025-01-01',
    '2025-12-31',
    1,
    'en_progreso',
    'system',
    NOW()
);

INSERT INTO transaccion (
    id_usuario,
    id_presupuesto,
    id_subcategoria,
    tipo_transaccion,
    descripcion,
    monto,
    fecha,
    metodo_pago,
    creado_por,
    creado_en
) VALUES
(1, 1, 24, 'gasto', 'Compra supermercado', 800, CURDATE(), 'tarjeta', 'system', NOW()),
(1, 1, 25, 'gasto', 'Cena restaurante', 400, CURDATE(), 'efectivo', 'system', NOW()),
(1, 1, 26, 'gasto', 'Factura energía', 600, CURDATE(), 'transferencia', 'system', NOW()),
(1, 1, 28, 'ingreso', 'Ahorro mensual', 500, CURDATE(), 'efectivo', 'system', NOW());
