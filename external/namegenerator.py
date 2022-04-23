import time
from datetime import datetime
import json 

FORMAT='%Y-%m'
fixed_name = "WebServer"
date=time.strftime("%d-%m-%Y")

result = {
  "name": f"{fixed_name}-{str(date)}",
}

print(json.dumps(result))