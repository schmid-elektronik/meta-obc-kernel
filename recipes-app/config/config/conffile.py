import configparser

class ConfFile:
    """
    - read and write configuration file
    - translate WebAPI json into init file
    init files are readable in bash (cat | grep) and in boost config
    """

    def __init__(self, path):
        self.config_file = path
        self.config = configparser.ConfigParser()
        # makes configpartser CaseSensitive
        self.config.optionxform = str

        # read own config file, don't care if there is no file, we'll generate a new one
        try:
            self.config.read(self.config_file)
        except:
            pass

    def write(self, c):
        """
        write config file
        c: dictionary containing the configuration
        """
        self.config.read_dict(c)

        with open(self.config_file, 'w') as f:
            self.config.write(f, space_around_delimiters=False)

    def get_teamno(self):
        if self.config.has_option('team', 'TeamNo'):
            return self.config['team']['TeamNo']

        return 0

    def get_error_description_source(self):
        if self.config.has_option('obc', 'ip_error_conf'):
            return self.config['obc']['ip_error_conf']

        return 0

    def get_config_source(self):
        """
        read own inifile
        returns list of configuration source
        FIXME, function must know the configfilestructure, which is hold in semapi class
        """
        c = []
        default_src = 'https://manager.sem-app.com/ws/obcmgr/config/'

        # multiple sources in format
        # ip_conf_0=myip0
        # ip_conf_1=dnsentry_xyz
        i = 0
        while(self.config.has_option('obc','ip_conf_' + str(i))):
            c.append(self.config['obc']['ip_conf_' + str(i)])
            i += 1

        # we read the config_source_ from the own output file
        # append default in any case at the end as fallback
        c.append(default_src)

        return c
