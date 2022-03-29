import time
from datetime import datetime

FORMAT='%Y-%m-_T%H:%M'
fixed_name = "WebServer"
date=datetime.strptime(time.strftime(FORMAT, time.localtime()),FORMAT)

result = {
  "name": f"{fixed_name}-{str(date)}",
}

print(json.dumps(result))