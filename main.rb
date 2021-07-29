require "http"
def ban(token,guild,member)
  r = HTTP.auth("Bot #{token}").put("https://discord.com/api/v9/guilds/#{guild}/bans/#{member}")
  if r.code == 200||201||204
    print "Banned #{member}"
  elsif r.code == 400||401||404 
    print "Unable To Ban #{member}"
  elsif r.code == 429
    sleep(r.body["retry_after"])
    ban(token,guild,member)
  end
end
def main
  print "Guild ID:  "
  guild = gets.chomp
  token = "TOKEN HERE"
  f = File.open("users.txt","r").readlines
  for user in f
    ban(token,guild,user)
  end
end
main
