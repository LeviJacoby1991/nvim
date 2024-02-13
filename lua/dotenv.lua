local dotenv_status_ok, dotenv = pcall(require, 'dotenv')

if not dotenv_status_ok then
  return
end

dotenv.setup()
