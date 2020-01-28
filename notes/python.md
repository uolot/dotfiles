# Basic logging

```python
import logging

formatter = logging.Formatter(logging.BASIC_FORMAT)
handler = logging.StreamHandler()
handler.setFormatter(formatter)
log = logging.getLogger()
log.addHandler(handler)
log.setLevel(logging.INFO)

log.info("hello")
```


# Timed cache

```python
class timed_cache:
    """A decorator that caches wrapped function for specified amount of time.

    Example:

    @timed_cache(ttl=10)
    def foo():
        r = random.randint(1, 100)
        print("r:", r)
        return r
    """

    def __init__(self, *, ttl):
        """ttl: ttl in seconds"""
        self.ttl = ttl
        self.time = None
        self.result = None

    def __call__(self, f):
        def wrapped_f(*args, **kwargs):
            current_time = time.time()
            if (
                self.time is None
                or self.result is None
                or current_time - self.time > self.ttl
            ):
                self.result = f(*args, **kwargs)
                self.time = time.time()
            return self.result

        return wrapped_f
```


# Example Lambda handler for Firehose

```python
from __future__ import print_function

import base64
import datetime
import json


def lambda_handler(event, context):
    output = []

    for record in event["records"]:
        payload = json.loads(base64.b64decode(record["data"]))

        # Add a field to the record if doesn't exist
        if not payload.get("foo"):
            payload["foo"] = datetime.datetime.now().isoformat(" ")

        output_record = {
            "recordId": record["recordId"],
            "result": "Ok",
            "data": base64.b64encode(json.dumps(payload).encode()).decode(),
        }
        output.append(output_record)

    return {"records": output}
```
