require 'rubygems'
require 'xeroizer'

# Create client (used to communicate with the API).
client = Xeroizer::PublicApplication.new('FVWZC6GMMXJX3LCSWU92EFCSKEBEP6', 'KCZ3HRPOMPKXTNDLRETLK39QVGCG0O')

# Retrieve list of contacts (note: all communication must be made through the client).
contacts = client.Contact.all(:order => 'Name')