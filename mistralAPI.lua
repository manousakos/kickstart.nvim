-- Create a formatted user/assistant message
local function createMessage(role, content)
  return { role = role, content = content }
end

-- Properly escape JSON strings
local function escapeJson(str)
  return str:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n'):gsub('\r', '\\r'):gsub('\t', '\\t'):gsub('\b', '\\b'):gsub('\f', '\\f'):gsub('/', '\\/')
end

-- Encode messages as JSON string with proper escaping
local function encodeMessages(messages)
  local parts = {}
  for _, msg in ipairs(messages) do
    local safe_content = escapeJson(msg.content)
    local safe_role = escapeJson(msg.role)
    table.insert(parts, string.format('{"role":"%s","content":"%s"}', safe_role, safe_content))
  end
  return '[' .. table.concat(parts, ',') .. ']'
end

-- Function to send prompt via curl
local function apiCall(messages)
  local api_key = 'uooihon' -- Replace with env var or .env loader for safety
  if not api_key then
    error 'MISTRAL_API_KEY not found in environment.'
  end

  local messages_json = encodeMessages(messages)
  local json_data = string.format(
    [[{
  "model": "mistral-small",
  "messages": %s,
  "temperature": 0.7
}]],
    messages_json
  )

  -- Write JSON to temporary file to avoid shell escaping issues
  local temp_file = os.tmpname()
  local file = io.open(temp_file, 'w')
  if not file then
    error 'Could not create temporary file'
  end
  file:write(json_data)
  file:close()

  local cmd = string.format(
    'curl -s -X POST https://api.mistral.ai/v1/chat/completions '
      .. '-H "Authorization: Bearer %s" '
      .. '-H "Content-Type: application/json" '
      .. '--data-binary @%s',
    api_key,
    temp_file
  )

  local handle = io.popen(cmd)
  local result = handle:read '*a'
  handle:close()

  -- Clean up temp file
  os.remove(temp_file)

  -- Extract assistant reply from raw JSON (naively)
  local reply = result:match [["content"%s*:%s*"([^"\\]*(\\.[^"\\]*)*)]]
  if reply then
    -- Unescape basic JSON escapes in the reply
    reply = reply:gsub('\\"', '"'):gsub('\\\\', '\\'):gsub('\\n', '\n'):gsub('\\r', '\r'):gsub('\\t', '\t')
  end

  return reply or 'No reply from Mistral'
end

-- Print full conversation
local function printChat(chat)
  print '\n--- Conversation ---'
  for i, msg in ipairs(chat) do
    print(string.format('[%d] %s: %s', i, msg.role, msg.content))
  end
  print '--------------------\n'
end

-- Conversation loop
local function convo()
  print "Mistral Assistant. Type 'exit' to quit.\n"
  local chat = {}

  while true do
    io.write 'You: '
    local prompt = io.read()
    if prompt == nil or prompt:lower() == 'exit' then
      print 'Goodbye.'
      break
    end

    table.insert(chat, createMessage('user', prompt))
    local response = apiCall(chat)
    print('Mistral:', response)
    table.insert(chat, createMessage('assistant', response))

    -- Show the full chat after each exchange
    printChat(chat)
  end
end

-- Run it
convo()
