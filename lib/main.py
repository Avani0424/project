from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn

app = FastAPI()

# Define the expected resume data
class ResumeData(BaseModel):
    first_name: str
    last_name: str
    email: str
    age: str
    phone_number: str
    city: str
    country: str
    achievements: str

@app.post("/submit_resume/")
async def submit_resume(resume: ResumeData):
    return {
        "message": "Resume submitted successfully",
        "first_name": resume.first_name,
        "last_name": resume.last_name,
        "email": resume.email
    }

@app.get("/ping", status_code=200)
async def ping():
    return {"message": "Server is up and running"}

# Run FastAPI server
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)
