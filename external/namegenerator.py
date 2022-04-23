import json
import uuid

FORMAT='%Y-%m'
fixed_name = "WEB"
uuid = uuid.uuid1()

result = {
  "name": f"{fixed_name}-{uuid}",
}

print(json.dumps(result))