from dataclasses import dataclass
from typing import Optional

@dataclass
class Counter:
    id: str
    count: int

    def __post_init__(self):
        if self.id is None:
            raise ValueError("id cannot be None")
