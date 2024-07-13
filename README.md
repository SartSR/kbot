Telebot project  t.me/sartsr_bot
GoLang (cobra-cli,telebot v3)
export GOPATH=$HOME/go
go install github.com/spf13/cobra-cli@latest
cobra-cli init
go get
go build -ldflags "-X 'github.com/SartSR/kbot/cmd.appVersion=v1.0.0'"
read -s TELE_TOKEN
export TELE_TOKEN
./kbot start

example command
/start hello - return version app
/start time - return current time
/start ping - return "Pong"

