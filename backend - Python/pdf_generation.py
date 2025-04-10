import os
import subprocess
from jinja2 import Environment, FileSystemLoader
from fastapi.responses import FileResponse
import uuid

def generate_resume_pdf(data):
    # Setup paths
    template_dir = "templates"
    output_dir = "resumes"
    os.makedirs(output_dir, exist_ok=True)

    env = Environment(loader=FileSystemLoader(template_dir))
    template = env.get_template("resume_template.tex")

    # Render LaTeX
    rendered_tex = template.render(data)

    # Save .tex file
    unique_id = str(uuid.uuid4())
    tex_path = os.path.join(output_dir, f"{unique_id}.tex")
    pdf_path = os.path.join(output_dir, f"{unique_id}.pdf")

    with open(tex_path, "w") as f:
        f.write(rendered_tex)

    # Compile LaTeX
    try:
        result = subprocess.run(
            ["pdflatex", "-interaction=nonstopmode", "-output-directory", output_dir, tex_path],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=15
        )
    except FileNotFoundError:
        raise RuntimeError("pdflatex is not installed or not in PATH.")
    except subprocess.TimeoutExpired:
        raise RuntimeError("pdflatex compilation timed out.")

    # Check success
    if result.returncode != 0:
        print("LaTeX compilation failed:")
        print(result.stdout.decode())
        print(result.stderr.decode())
        raise RuntimeError("PDF generation failed. Check LaTeX template or pdflatex setup.")

    # Confirm output file exists
    if not os.path.exists(pdf_path):
        raise RuntimeError("PDF file was not created.")

    return pdf_path
