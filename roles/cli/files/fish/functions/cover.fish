function cover
    set t "/tmp/go-cover.$fish_pid.tmp"
    go test ./... -coverprofile=$t $argv && go tool cover -html=$t && unlink $t
end
