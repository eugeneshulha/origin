SETTINGS = [
    # global general settings
    Dir.glob("#{CorevistAPI::Engine.root}/config/*.yml")

    # To add folder with configs use
    # Dir.glob("#{CorevistAPI::Engine.root}/config/folder_name/*.yml")
    #
    # To add single file use
    # "#{CorevistAPI::Engine.root}/config/folder_name/file_name.yml"
].flatten

Settings.reload_from_files(SETTINGS)