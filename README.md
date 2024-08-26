# Telebot project  t.me/sartsr_bot
## contain pre-commit script sample in /scripts/pre-commit.samle
## copy and rename to local './.git/hooks/pre-commit' directory, script will work fully autonomous, just check ## gitleaks-report.json
### GoLang (cobra-cli,telebot v3)
``` go
export GOPATH=$HOME/go
go install github.com/spf13/cobra-cli@latest
cobra-cli init
go get
go build -ldflags "-X 'github.com/SartSR/kbot/cmd.appVersion=v1.0.2'"
read -s TELE_TOKEN
export TELE_TOKEN
```
./kbot start

example command

/start hello - return version app

/start time - return current time

/start ping - return "Pong"



