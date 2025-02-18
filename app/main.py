from fastapi import FastAPI

app = FastAPI(
    docs_url="/api-docs",
)

@app.get("/")
def read_root():
    return {"Hello": "World"}