# Modo: pdf — Generacion de PDF ATS-Optimizado (Typst)

## Pipeline completo

1. Lee `cv.md` como fuente de verdad
2. Pide al usuario el JD si no esta en contexto (texto o URL)
3. Extrae 15-20 keywords del JD
4. Detecta idioma del JD -> idioma del CV (EN default)
5. Detecta ubicacion empresa -> formato papel:
   - US/Canada -> `letter` (us-letter)
   - Resto del mundo -> `a4`
6. Detecta arquetipo del rol -> adapta framing
7. Reescribe Professional Summary inyectando keywords del JD + exit narrative bridge ("Built and sold a business. Now applying systems thinking to [domain del JD].")
8. Selecciona top 3-4 proyectos mas relevantes para la oferta
9. Reordena bullets de experiencia por relevancia al JD
10. Construye competency grid desde requisitos del JD (6-8 keyword phrases)
11. Inyecta keywords naturalmente en logros existentes (NUNCA inventa)
12. Modifica `templates/typst/resume.typ` con el contenido personalizado (ver seccion "Typst Resume Template" abajo)
13. Ejecuta: `node generate-pdf.mjs templates/typst/resume.typ output/cv-candidate-{company}-{YYYY-MM-DD}.pdf`
14. Reporta: ruta del PDF, nro paginas, % cobertura de keywords

## Reglas ATS (parseo limpio)

- Layout single-column (sin sidebars, sin columnas paralelas)
- Headers estandar: "Experience", "Education", "Skills", "Projects"
- Sin texto en imagenes/SVGs
- Sin info critica en headers/footers del PDF (ATS los ignora)
- UTF-8, texto seleccionable (no rasterizado)
- Sin tablas anidadas
- Keywords del JD distribuidas: Summary (top 5), primer bullet de cada rol, Skills section

## Typst Resume Template

The CV is generated from `templates/typst/resume.typ` which imports `templates/typst/template.typ`. Fonts are in `templates/typst/assets/fonts/` (Mulish family).

### How to tailor resume.typ

When tailoring for a job, you modify `templates/typst/resume.typ` directly. The file uses Typst markup with helper functions defined in `template.typ`. Here is what to update:

#### 1. Contact info

Update the `name` and `contact` fields inside the `#show: project.with(...)` call to match the candidate from `cv.md` and `config/profile.yml`:

```typst
#show: project.with(
  theme: rgb("#0F83C0"),
  name: "Candidate Name",
  contact: (
    contact(text: "LinkedIn://handle", link: "https://www.linkedin.com/in/handle"),
    contact(text: "Github://handle", link: "https://www.github.com/handle"),
    contact(text: "portfolio.dev", link: "https://portfolio.dev"),
    contact(text: "email@example.com", link: "mailto:email@example.com"),
  ),
```

#### 2. Experience section

Each job is a `subSection(...)` inside a `section(title: "Experience", ...)`. Update:
- `title` / `titleEnd`: company name and location
- `subTitle` / `subTitleEnd`: role title and date range
- `content`: bullet points using `#list(...)` blocks

Reorder bullets by JD relevance. Inject keywords naturally into existing achievements. Group bullets under bold sub-headers if the candidate had multiple focus areas at one company.

Example bullet with keyword injection:
```typst
#list(
  [Designed and deployed *RAG pipelines* for semantic search over security telemetry, improving query accuracy by 35%.],
  [Led *MLOps* and observability initiatives: eval frameworks, error monitoring, cost tracking.],
)
```

#### 3. Education section

Update the `section(title: "Education", ...)` block with data from `cv.md`.

#### 4. Projects section (optional)

If the candidate has relevant projects, add a `section(title: "Projects", ...)` block after Experience with the top 3-4 most relevant projects as `subSection` entries.

#### 5. Skills section (optional)

If a skills grid is needed, add a section or use the `skills` parameter in `project.with(...)`:
```typst
skills: (languages: ("Python", "TypeScript", "Rust", "SQL")),
```

### Important rules for Typst content

- Use `*bold text*` for bold (NOT `**`)
- Use `#list(...)` for bullet points
- Use `[...]` for content blocks inside Typst functions
- Escape special Typst characters if needed: `#`, `*`, `@`, `<`, `>`
- **MUST fit on 1 page** (see Content Constraints). If it overflows, trim least-relevant bullets or drop a role
- The theme color can be adjusted via `theme: rgb("#XXXXXX")` to match company branding if desired

## Content Constraints

- **Single Page Strict Limit:** The resulting `resume.typ` MUST compile to exactly one page. If the compiled PDF exceeds one page, trim content until it fits. Never ship a two-page resume.
- **Trim the Fat:** Limit Experience bullet points to a maximum of 3-4 high-impact, metrics-driven bullets per role. Do NOT blindly copy every bullet from `cv.md` -- select only the most relevant and quantified achievements for the target JD. If space is still tight, drop the least-relevant role entirely.
- **Education First, No Coursework:** Place the Education section immediately after Experience (before Projects/Skills) since the candidate is a recent grad. Always strip out "Relevant Coursework" lines -- they consume vertical space and add little ATS value compared to skills and experience bullets.

## Estrategia de keyword injection (etico, basado en verdad)

Ejemplos de reformulacion legitima:
- JD dice "RAG pipelines" y CV dice "LLM workflows with retrieval" -> cambiar a "RAG pipeline design and LLM orchestration workflows"
- JD dice "MLOps" y CV dice "observability, evals, error handling" -> cambiar a "MLOps and observability: evals, error handling, cost monitoring"
- JD dice "stakeholder management" y CV dice "collaborated with team" -> cambiar a "stakeholder management across engineering, operations, and business"

**NUNCA anadir skills que el candidato no tiene. Solo reformular experiencia real con el vocabulario exacto del JD.**

## Canva CV Generation (optional)

If `config/profile.yml` has `canva_resume_design_id` set, offer the user a choice before generating:
- **"Typst/PDF (fast, ATS-optimized)"** -- existing flow above
- **"Canva CV (visual, design-preserving)"** -- new flow below

If the user has no `canva_resume_design_id`, skip this prompt and use the Typst/PDF flow.

### Canva workflow

#### Step 1 -- Duplicate the base design

a. `export-design` the base design (using `canva_resume_design_id`) as PDF -> get download URL
b. `import-design-from-url` using that download URL -> creates a new editable design (the duplicate)
c. Note the new `design_id` for the duplicate

#### Step 2 -- Read the design structure

a. `get-design-content` on the new design -> returns all text elements (richtexts) with their content
b. Map text elements to CV sections by content matching:
   - Look for the candidate's name -> header section
   - Look for "Summary" or "Professional Summary" -> summary section
   - Look for company names from cv.md -> experience sections
   - Look for degree/school names -> education section
   - Look for skill keywords -> skills section
c. If mapping fails, show the user what was found and ask for guidance

#### Step 3 -- Generate tailored content

Same content generation as the Typst flow (Steps 1-11 above):
- Rewrite Professional Summary with JD keywords + exit narrative
- Reorder experience bullets by JD relevance
- Select top competencies from JD requirements
- Inject keywords naturally (NEVER invent)

**IMPORTANT -- Character budget rule:** Each replacement text MUST be approximately the same length as the original text it replaces (within +/-15% character count). If tailored content is longer, condense it. The Canva design has fixed-size text boxes -- longer text causes overlapping with adjacent elements. Count the characters in each original element from Step 2 and enforce this budget when generating replacements.

#### Step 4 -- Apply edits

a. `start-editing-transaction` on the duplicate design
b. `perform-editing-operations` with `find_and_replace_text` for each section:
   - Replace summary text with tailored summary
   - Replace each experience bullet with reordered/rewritten bullets
   - Replace competency/skills text with JD-matched terms
   - Replace project descriptions with top relevant projects
c. **Reflow layout after text replacement:**
   After applying all text replacements, the text boxes auto-resize but neighboring elements stay in place. This causes uneven spacing between work experience sections. Fix this:
   1. Read the updated element positions and dimensions from the `perform-editing-operations` response
   2. For each work experience section (top to bottom), calculate where the bullets text box ends: `end_y = top + height`
   3. The next section's header should start at `end_y + consistent_gap` (use the original gap from the template, typically ~30px)
   4. Use `position_element` to move the next section's date, company name, role title, and bullets elements to maintain even spacing
   5. Repeat for all work experience sections
d. **Verify layout before commit:**
   - `get-design-thumbnail` with the transaction_id and page_index=1
   - Visually inspect the thumbnail for: text overlapping, uneven spacing, text cut off, text too small
   - If issues remain, adjust with `position_element`, `resize_element`, or `format_text`
   - Repeat until layout is clean
d. Show the user the final preview and ask for approval
e. `commit-editing-transaction` to save (ONLY after user approval)

#### Step 5 -- Export and download PDF

a. `export-design` the duplicate as PDF (format: a4 or letter based on JD location)
b. **IMMEDIATELY** download the PDF using Bash:
   ```bash
   curl -sL -o "output/cv-{candidate}-{company}-canva-{YYYY-MM-DD}.pdf" "{download_url}"
   ```
   The export URL is a pre-signed S3 link that expires in ~2 hours. Download it right away.
c. Verify the download:
   ```bash
   file output/cv-{candidate}-{company}-canva-{YYYY-MM-DD}.pdf
   ```
   Must show "PDF document". If it shows XML or HTML, the URL expired -- re-export and retry.
d. Report: PDF path, file size, Canva design URL (for manual tweaking)

#### Error handling

- If `import-design-from-url` fails -> fall back to Typst/PDF pipeline with message
- If text elements can't be mapped -> warn user, show what was found, ask for manual mapping
- If `find_and_replace_text` finds no matches -> try broader substring matching
- Always provide the Canva design URL so the user can edit manually if auto-edit fails

## Post-generacion

Actualizar tracker si la oferta ya esta registrada: cambiar PDF de X a checkmark.
