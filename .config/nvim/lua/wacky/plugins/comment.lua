local setup, comment = pcall(require, "Comment")
if not setup then
    print("comment failed...")
	return
end

comment.setup()
