#!/usr/bin/env node

/**
 * generate-pdf.mjs — Typst → PDF via typst CLI
 *
 * Usage:
 *   node generate-pdf.mjs <input.typ> <output.pdf> [--format=letter|a4]
 *
 * Requires: typst CLI installed (https://github.com/typst/typst)
 * Compiles the Typst source file into a clean, ATS-parseable PDF.
 */

import { execSync } from 'child_process';
import { resolve, dirname } from 'path';
import { statSync } from 'fs';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

function generatePDF() {
  const args = process.argv.slice(2);

  // Parse arguments
  let inputPath, outputPath, format = 'a4';

  for (const arg of args) {
    if (arg.startsWith('--format=')) {
      format = arg.split('=')[1].toLowerCase();
    } else if (!inputPath) {
      inputPath = arg;
    } else if (!outputPath) {
      outputPath = arg;
    }
  }

  if (!inputPath || !outputPath) {
    console.error('Usage: node generate-pdf.mjs <input.typ> <output.pdf> [--format=letter|a4]');
    process.exit(1);
  }

  inputPath = resolve(inputPath);
  outputPath = resolve(outputPath);

  // Validate format
  const validFormats = ['a4', 'letter'];
  if (!validFormats.includes(format)) {
    console.error(`Invalid format "${format}". Use: ${validFormats.join(', ')}`);
    process.exit(1);
  }

  // Map format to Typst page size input values
  const typstPageSize = format === 'letter' ? 'us-letter' : 'a4';

  console.log(`📄 Input:  ${inputPath}`);
  console.log(`📁 Output: ${outputPath}`);
  console.log(`📏 Format: ${format.toUpperCase()}`);

  // Resolve the font directory (assets/fonts relative to the input .typ file)
  const fontDir = resolve(dirname(inputPath), 'assets', 'fonts');

  // Build the typst compile command
  const cmd = [
    'typst', 'compile',
    `--font-path`, fontDir,
    `--input`, `page-size=${typstPageSize}`,
    inputPath,
    outputPath,
  ].map(s => `"${s}"`).join(' ');

  try {
    execSync(cmd, { stdio: 'inherit', cwd: dirname(inputPath) });
  } catch (err) {
    console.error('❌ PDF generation failed. Is typst CLI installed?');
    console.error('   Install: https://github.com/typst/typst#installation');
    process.exit(1);
  }

  // Report stats
  const stat = statSync(outputPath);
  const sizeKB = (stat.size / 1024).toFixed(1);

  // Rough page count from PDF structure
  const pdfBytes = readFileSync(outputPath, 'latin1');
  const pageCount = (pdfBytes.match(/\/Type\s*\/Page[^s]/g) || []).length;

  console.log(`✅ PDF generated: ${outputPath}`);
  console.log(`📊 Pages: ${pageCount}`);
  console.log(`📦 Size: ${sizeKB} KB`);

  return { outputPath, pageCount, size: stat.size };
}

generatePDF();
