# Code generated by sqlc. DO NOT EDIT.
# versions:
#   sqlc v1.28.0
import datetime
import pydantic
from typing import Optional


class Author(pydantic.BaseModel):
    id: int
    name: str
    bio: Optional[str]
    created_at: datetime.datetime
