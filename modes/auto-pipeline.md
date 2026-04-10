# Modo: auto-pipeline — Pipeline Completo Automático

Cuando el usuario pega un JD (texto o URL) sin sub-comando explícito, ejecutar TODO el pipeline en secuencia:

## Paso 0 — Extraer JD

Si el input es una **URL** (no texto de JD pegado), seguir esta estrategia para extraer el contenido:

**Orden de prioridad:**

1. **Playwright (preferido):** La mayoría de portales de empleo (Lever, Ashby, Greenhouse, Workday) son SPAs. Usar `browser_navigate` + `browser_snapshot` para renderizar y leer el JD.
2. **WebFetch (fallback):** Para páginas estáticas (ZipRecruiter, WeLoveProduct, company career pages).
3. **WebSearch (último recurso):** Buscar título del rol + empresa en portales secundarios que indexan el JD en HTML estático.

**Si ningún método funciona:** Pedir al candidato que pegue el JD manualmente o comparta un screenshot.

**Si el input es texto de JD** (no URL): usar directamente, sin necesidad de fetch.

## Paso 1 — Evaluación A-F
Ejecutar exactamente igual que el modo `oferta` (leer `modes/oferta.md` para todos los bloques A-F).

## Paso 2 — Guardar Report .md
Guardar la evaluación completa en `reports/{###}-{company-slug}-{YYYY-MM-DD}.md` (ver formato en `modes/oferta.md`).

## Paso 3 — Generar PDF
Ejecutar el pipeline completo de `pdf` (leer `modes/pdf.md`).

## Paso 4 — Draft Application Answers (solo si score >= 4.5)

Si el score final es >= 4.5, generar borrador de respuestas para el formulario de aplicación:

1. **Extraer preguntas del formulario**: Usar Playwright para navegar al formulario y hacer snapshot. Si no se pueden extraer, usar las preguntas genéricas.
2. **Generar respuestas** siguiendo el tono (ver abajo).
3. **Guardar en el report** como sección `## G) Draft Application Answers`.

### Preguntas genéricas (usar si no se pueden extraer del formulario)

- Why are you interested in this role?
- Why do you want to work at [Company]?
- Tell us about a relevant project or achievement
- What makes you a good fit for this position?
- How did you hear about this role?

### Tono para Form Answers

**Posición: "I'm choosing you."** el candidato tiene opciones y está eligiendo esta empresa por razones concretas.

**Reglas de tono:**
- **Confiado sin arrogancia**: "I've spent the past year building production AI agent systems — your role is where I want to apply that experience next"
- **Selectivo sin soberbia**: "I've been intentional about finding a team where I can contribute meaningfully from day one"
- **Específico y concreto**: Siempre referenciar algo REAL del JD o de la empresa, y algo REAL de la experiencia del candidato
- **Directo, sin fluff**: 2-4 frases por respuesta. Sin "I'm passionate about..." ni "I would love the opportunity to..."
- **El hook es la prueba, no la afirmación**: En vez de "I'm great at X", decir "I built X that does Y"

**Framework por pregunta:**
- **Why this role?** → "Your [specific thing] maps directly to [specific thing I built]."
- **Why this company?** → Mencionar algo concreto sobre la empresa. "I've been using [product] for [time/purpose]."
- **Relevant experience?** → Un proof point cuantificado. "Built [X] that [metric]. Sold the company in 2025."
- **Good fit?** → "I sit at the intersection of [A] and [B], which is exactly where this role lives."
- **How did you hear?** → Honesto: "Found through [portal/scan], evaluated against my criteria, and it scored highest."

**Idioma**: Siempre en el idioma del JD (EN default). Aplicar `/tech-translate`.

## Paso 5 — Actualizar Tracker
Registrar en `data/applications.md` con todas las columnas incluyendo Report y PDF en ✅.

**Si algún paso falla**, continuar con los siguientes y marcar el paso fallido como pendiente en el tracker.

## Paso 6 — Auto-Submit Application

**Trigger:** Score final >= 4.0.

Si el score es >= 4.0, proceder automáticamente a enviar la aplicación usando Playwright:

1. **Localizar el punto de entrada**: Desde la página del JD (ya cargada en Paso 0), buscar el botón "Apply", "Apply Now", "Submit Application", o enlace equivalente. Usar `browser_snapshot` para identificar el elemento y `browser_click` para hacer clic.

2. **Completar el formulario**:
   - **Datos personales** (nombre, email, teléfono, ubicación): Leer de `config/profile.yml`.
   - **CV/Resume upload**: Subir el PDF compilado en Paso 3 (ruta: `output/{company-slug}-{role-slug}.pdf`) usando `browser_file_upload` en el campo de archivo correspondiente.
   - **Respuestas a preguntas**: Usar las respuestas generadas en Paso 4. Si Paso 4 no se ejecutó (score entre 4.0 y 4.5), generar las respuestas en este momento siguiendo el mismo framework de tono y preguntas del Paso 4.
   - **LinkedIn/portfolio URLs**: Leer de `config/profile.yml` si los campos existen en el formulario.
   - **Campos desconocidos**: Si el formulario contiene campos no mapeables desde el perfil o CV, hacer `browser_snapshot`, intentar inferir la respuesta desde `cv.md` o `config/profile.yml`. Si no es posible, dejar en blanco o usar el placeholder más razonable.

3. **Revisar antes de enviar**: Hacer un `browser_snapshot` final del formulario completo para verificar que todos los campos están llenos y correctos.

4. **Enviar**: Hacer clic en el botón final de submit ("Submit", "Send Application", "Apply", o equivalente) sin esperar confirmación del usuario — la autorización está dada en CLAUDE.md y AGENTS.md.

5. **Confirmar envío**: Hacer `browser_snapshot` de la página de confirmación. Verificar que el envío fue exitoso (buscar mensajes como "Application submitted", "Thank you", etc.).

6. **Actualizar tracker**: Cambiar el status en `data/applications.md` de `Evaluated` a `Applied` y agregar nota con fecha de envío.

**Si el formulario requiere autenticación (login):** Informar al usuario y NO proceder. Marcar en tracker como `Evaluated` con nota `Auto-submit blocked: login required`.

**Si el envío falla (error de red, CAPTCHA, campo obligatorio no mapeado):** Marcar en tracker como `Evaluated` con nota `Auto-submit failed: {razón}`. El usuario puede reintentar manualmente con `/career-ops apply`.
