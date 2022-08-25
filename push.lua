function gitpush()
    -- pull with all changes
    os.execute("git pull")
    -- add all
    os.execute("git add --all")
    -- commit with message
    os.execute("git commit -m " .. '"' .. message .. '"')
    -- push to repo
    os.execute("git push origin master")
    os.execute("cls")
end


print("type a message to commit")
message = io.read("*l")
gitpush()