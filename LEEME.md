# Control de Unidades (SERTEXA · 007 y 017)

Aplicación web para registrar ingresos diarios, gastos y reparaciones, adeudos con abonos, y generar cortes diarios, semanales, mensuales y por unidad. Está en español, usa pesos mexicanos y fechas día/mes/año.

## Ponerla como ícono en el celular (Android)

1. Abre el enlace https://claude.ai/artifact/SirDvqvHHXDJFiK23MD9UE en **Chrome** (no en la app de Claude) e inicia sesión en claude.ai si te lo pide.
2. Toca el menú **⋮** (arriba a la derecha) → **Agregar a la pantalla principal** → **Agregar**.
3. Queda un ícono en tu pantalla que abre la app directo, con los mismos datos de la nube.

Si prefieres una app instalada que funcione sin internet, usa la opción B de abajo (sus datos quedan solo en el teléfono).

## Cómo abrirla

**Opción A (recomendada): en claude.ai**
Abre el enlace del Artifact: https://claude.ai/artifact/SirDvqvHHXDJFiK23MD9UE
- Funciona en el navegador del teléfono, en la app de Claude y en la computadora, con tu cuenta.
- Los datos se guardan en la base de datos del Artifact, en servidor. Ves lo mismo desde el teléfono y desde la computadora.
- Necesita internet.

**Opción B: como app propia, sin Claude**
La carpeta `dist/` es la app completa (`index.html` + manifest + service worker + íconos).
1. Para probarla en una computadora: abre `dist/index.html` con Chrome o Edge.
2. Para instalarla en Android como app: sube la carpeta `dist/` a un hosting con https (por ejemplo, arrastrando la carpeta a Netlify Drop o publicándola en GitHub Pages), abre la dirección en Chrome del teléfono y elige **Menú ⋮ → Agregar a pantalla principal / Instalar app**. Después funciona sin internet.
- En esta opción los datos se guardan en IndexedDB **de ese navegador en ese dispositivo**. No se sincronizan con otros dispositivos ni con el Artifact.

Las dos opciones usan el mismo formato de respaldo, así que puedes pasar datos de una a otra con Descargar respaldo → Importar.

## Respaldos

Menú **Más → Respaldo**:
- **Descargar respaldo JSON**: guarda todo (unidades, ingresos, gastos, adeudos, abonos, categorías y fotos de comprobantes). Guárdalo en Drive o mándatelo por correo. El inicio te avisa si pasan 7 días sin respaldo.
- **Importar**: valida el archivo antes de tocar nada y te muestra qué contiene. Luego eliges:
  - **Combinar sin duplicar**: agrega lo nuevo y actualiza lo más reciente, por identificador. Importar el mismo respaldo dos veces no duplica.
  - **Reemplazar todo**: pide confirmación explícita y sustituye la información actual.
- **Todos los movimientos en CSV**: para Excel u hojas de cálculo.

## Qué incluye

1. **Inicio**: cuenta del día por unidad (esperado vs. recibido, o "Sin captura"), ingresos, gastos y balance de hoy, semana y mes, adeudos por cobrar y por pagar, gastos del mes por unidad y gráfica de 14 días. Filtros de fecha y unidad.
2. **Captura diaria**: formulario corto con la unidad en botones grandes, operador automático según la fecha, botones de "Cuenta $3,000" o "Resto $X", tipo de entrega (completa, parcial, extraordinaria) y días anteriores. Varias entregas por día sin sobrescribir.
3. **Gastos**: categoría (se pueden crear nuevas), descripción exacta, proveedor, forma de pago, kilometraje y foto de comprobante. Filtros por día, semana, mes, rango, unidad, categoría y proveedor.
4. **Adeudos**: me deben / yo debo, historial de abonos, saldo = original − abonos válidos, estados automáticos, aviso de vencido, confirmación para abonos mayores al saldo y saldos por persona.
5. **Calendario**: Mes → Semana (lunes a domingo) → Día → Movimientos. Los días sin captura se marcan como tales. Las semanas que cruzan meses solo suman los días del mes elegido.
6. **Cortes**: diario, semanal, mensual (con categorías, comparativo de unidades, adeudos al cierre y meses anteriores) y por unidad. Se exportan a CSV y Excel. Dentro de claude.ai se descargan como archivo HTML que se abre y se imprime o se guarda como PDF; en la app propia se imprimen directo.
7. **Unidades**: alta y edición, cuentas esperadas L-V y fin de semana, cambio de operador con fecha (el historial conserva quién entregó cada día), bitácora de mantenimiento, baja sin perder historial.
8. **Comisión del administrador** (menú Más → Comisión): Efrén Cárcamo cobra el 11% del ingreso bruto de cada semana de lunes a domingo, con corte el domingo. Muestra la comisión de la semana en curso, las semanas pendientes y el desglose por unidad. "Registrar pago" crea el gasto de categoría "Comisión del administrador", repartido entre las unidades según su ingreso, y así entra al balance solo cuando se paga. El nombre, el porcentaje y la semana de inicio se editan ahí mismo. También aparece en Inicio y en el corte semanal.
9. **Respaldo y configuración**: respaldos, datos de prueba, categorías, bitácora de cambios y borrado total.

**Correcciones**: cada registro se puede editar, **anular** (queda marcado ANULADO y deja de sumar) o eliminar con confirmación. Eliminar un adeudo con abonos pide una confirmación especial. Cada registro guarda su historial de cambios.

**Datos reales cargados al iniciar**: unidad 007 (Ángel Chimil, $3,000 L-V, $2,800 fin de semana), unidad 017 (Jorge Bolaños, $2,600 L-V, $2,800 fin de semana), adeudo de Jorge Bolaños por $20,000 y de Ángel Chimil por $500, ambos "me deben", con fecha del primer día de uso. Si la fecha o el concepto no son correctos, edítalos en Adeudos.

**Datos de prueba**: botón "Cargar datos de prueba" en Respaldo. Todos llevan la etiqueta PRUEBA y se borran con "Eliminar datos de prueba" sin tocar los datos reales.

## Limitaciones reales

- En claude.ai los datos viven en la base de datos de ese Artifact. Si se elimina el Artifact, se borran sus datos. Límite: 25,000 registros, que alcanzan para varios años de uso con dos unidades.
- En la app propia (opción B) no hay sincronización en la nube: cada teléfono o navegador tiene su propia copia. Borrar los datos del sitio en el navegador borra la información.
- Los cálculos de Excel cargan una librería desde internet. Sin conexión se exporta CSV.
- Dentro de claude.ai no se puede abrir el diálogo de impresión directamente; por eso el corte se descarga como archivo y se imprime desde ahí.
- Los comprobantes se guardan como fotos reducidas (alrededor de 200 KB). No se aceptan PDF.

## Para una base de datos centralizada propia

`src/store.js` define la interfaz de almacenamiento (`init`, `put`, `putMany`, `remove`, `clear` y comprobantes). Hay dos implementaciones: `CloudStore` (Artifact) y `LocalStore` (IndexedDB). Para usar Supabase, Firebase o una API propia basta con escribir otra clase con esos métodos.

## Pruebas

```
node --test tests/core.test.js         # cálculos: ingresos, gastos, saldos, semanas, límites de mes, respaldos
node build.js                          # genera dist/
npx http-server dist -p 8090 &         # sirve la app
node tests/e2e.js                      # 34 pruebas en Chromium con pantalla de teléfono
```
Resultado del 20/10/2026: 8 de 8 pruebas de cálculo y 34 de 34 pruebas de extremo a extremo pasaron, incluida la comisión (11% de $5,600 = $616, repartido en $330 + $286). Cubren los cinco escenarios obligatorios: 3,000 + 2,580 = 5,580; gasto de 1,150 con balance de 4,430; adeudo de 20,000 con abono de 2,000 y saldo de 18,000 fuera del ingreso operativo; cortes consistentes, límites de mes y edición; persistencia tras recargar, y respaldo e importación sin duplicar.

## Archivos

- `src/core.js`: cálculos puros (centavos enteros, fechas, semanas, resúmenes, saldos, validación de respaldos).
- `src/store.js`: almacenamiento.
- `src/app.js`: pantallas.
- `src/styles.css`, `src/shell.html`: diseño.
- `build.js`: arma `dist/index.html` (app instalable) y `dist/artifact.html` (versión de claude.ai).
