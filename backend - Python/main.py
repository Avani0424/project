from fastapi import FastAPI
from fastapi.responses import FileResponse
from pydantic import BaseModel, EmailStr
import uvicorn
from typing import List, Optional
from gpt4all import GPT4All
from pdf_generation import generate_resume_pdf
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load GPT4All model
model_path = "models/ggml-nomic-ai-gpt4all-falcon-Q4_0.gguf"
gpt4all_model = GPT4All("ggml-nomic-ai-gpt4all-falcon-Q4_0", model_path=model_path, allow_download=False)

# Data Models
class ContactInfo(BaseModel):
    email: EmailStr
    phone: str
    linkedin: Optional[str] = None
    github: Optional[str] = None

class Experience(BaseModel):
    company: str
    position: str
    start_date: str
    end_date: Optional[str] = None
    responsibilities: List[str]

class Education(BaseModel):
    institution: str
    degree: str
    start_date: str
    end_date: str
    cgpa: Optional[float] = None

class Project(BaseModel):
    name: str
    description: str

class Certification(BaseModel):
    name: str
    year: int

class Resume(BaseModel):
    name: str
    contact: ContactInfo
    summary: str
    experience: List[Experience]
    projects: List[Project]
    education: Optional[List[Education]] = []
    skills: Optional[List[str]] = []
    certifications: Optional[List[Certification]] = []
    languages: Optional[List[str]] = []

# In-memory storage
resume_store = {}

# Smart text enhancement function
def enhance_text(text: str, prompt: str):
    full_prompt = f"{prompt.strip()}\n{text.strip()}"

    with gpt4all_model.chat_session():
        response = gpt4all_model.generate(full_prompt, max_tokens=150)

    cleaned_response = response.strip()
    lines = cleaned_response.splitlines()

    # Remove first line if it looks like an intro
    if lines:
        first_line = lines[0].lower()
        if (
            len(first_line.split()) <= 7 or
            any(keyword in first_line for keyword in [
                "sure", "here", "absolutely", "take a look", "updated", "improved"
            ])
        ):
            lines = lines[1:]

    final_text = " ".join([line.strip() for line in lines if line.strip()])
    return final_text.strip()

@app.post("/complete-resume")
def process_resume(resume_data: Resume):
    """
    Unified API endpoint that:
    1. Stores the resume data
    2. Enhances the resume content
    3. Generates a PDF
    4. Returns the PDF for download
    """
    # Step 1: Store the resume
    resume_id = len(resume_store) + 1
    resume_store[resume_id] = resume_data

    # Step 2: Enhance the resume
    enhanced_summary = enhance_text(
        resume_data.summary,
        "Improve this professional summary for a resume. Return only the enhanced content. Do not include any introductions or extra comments."
    )

    enhanced_experience = []
    for exp in resume_data.experience:
        improved_responsibilities = [
            enhance_text(
                resp,
                "Improve this work responsibility for a resume. Return only the enhanced content without introductions or comments:"
            ) for resp in exp.responsibilities
        ]

        enhanced_experience.append(Experience(
            company=exp.company,
            position=exp.position,
            start_date=exp.start_date,
            end_date=exp.end_date,
            responsibilities=improved_responsibilities
        ))

    enhanced_projects = []
    for proj in resume_data.projects:
        enhanced_description = enhance_text(
            proj.description,
            "Improve this project description for a resume. Return only the enhanced content without introductions or explanations:"
        )
        enhanced_projects.append(Project(
            name=proj.name,
            description=enhanced_description
        ))

    # Create enhanced resume object
    enhanced_resume = Resume(
        name=resume_data.name,
        contact=resume_data.contact,
        summary=enhanced_summary,
        experience=enhanced_experience,
        projects=enhanced_projects,
        education=resume_data.education,
        skills=resume_data.skills,
        certifications=resume_data.certifications,
        languages=resume_data.languages
    )

    resume_store[resume_id] = enhanced_resume

    # Step 3: Generate PDF
    pdf_file = generate_resume_pdf(enhanced_resume.dict())

    # Step 4: Return the PDF for download
    return FileResponse(pdf_file, media_type='application/pdf', filename=f"{resume_data.name.replace(' ', '_')}_resume.pdf")

@app.get("/resume/{resume_id}")
def get_resume(resume_id: int):
    if resume_id in resume_store:
        return resume_store[resume_id]
    return {"error": "Resume not found"}

@app.get("/ping", status_code=200)
async def ping():
    return {"message": "Server is up and running"}

# Run FastAPI server
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)