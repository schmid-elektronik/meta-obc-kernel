import requests
import datetime

class SemApi:
    """Them SEM Rest API to get configuration from Database"""
    def __init__(self, bb, obc):
        self.bb = bb
        self.obc = obc
        self.latest_conf = {
            'data': {}
        }

    def __request_conf(self, bb, addrs):
        """
        get REST API Json string
        return config sting --> check 'success' field
        """
        conf = {'success':False}

        for addr in addrs:
            try:
                r = requests.get(addr + "/" + str(bb))
            except Exception as e:
                conf['ErrorMessage'] = 'GET failed from url: ' + addr
                continue

            try:
                conf = r.json()
            except Exception as e:
                conf['ErrorMessage'] = 'No JSON at url: ' + r.url
                continue

            if conf['success']:
                conf['data']['ip_conf_active'] = r.url
                conf['data']['ip_conf_time'] = str(int(datetime.datetime.now().timestamp()))

            return conf

    def __web2ini(self, webconfig):
        """
        translates reveiced jsonstring into ini format
        TODO, one day change the REST API to return that format
        """
        c = {
            'team': {},
            'obc': {},
            'mobile': {},
            'mqtt': {},
            'manufacturer': {}
        }

        # team related configuration
        c['team']['TeamNo'] = webconfig['data']['tnr']
        c['team']['GFM'] = '1' if ( webconfig['data']['required_sensor'].find('GFM') >=0 ) else '0'
        c['team']['JM2'] = '1' if ( webconfig['data']['required_sensor'].find('JM2') >=0 ) else '0'
        c['team']['JM3'] = '1' if ( webconfig['data']['required_sensor'].find('JM3') >=0 ) else '0'
        c['team']['VOLT'] = '1' if ( webconfig['data']['required_sensor'].find('VOLT') >=0 ) else '0'
        c['team']['LFM'] = '1' if ( webconfig['data']['required_sensor'].find('LFM') >=0 ) else '0'
        c['team']['EngyAlwceSensor'] = webconfig['data']['allowance_sensor']
        c['team']['subcategory'] = webconfig['data']['subcategory']
        c['team']['category'] = webconfig['data']['category']
        c['team']['LfmDensity'] = webconfig['data']['LFMdensity']
        c['team']['LfmScale'] = webconfig['data']['LFMscale']
        c['team']['LfmCorrectionFactor'] = webconfig['data']['LFMcorrection']
        c['team']['AllEnergyGFM'] = webconfig['data']['AllEnergyGFM']
        c['team']['AllEnergyJM2'] = webconfig['data']['AllEnergyJM2']
        c['team']['AllEnergyJM3'] = webconfig['data']['AllEnergyJM3']
        c['team']['AllEnergyLFM'] = webconfig['data']['AllEnergyLFM']
        c['team']['ConfOk'] = 1

        # obc related configuration
        c['obc']['use_wifi'] = webconfig['data']['use_wifi']

        # config source is a comma separated list, create multiple entries like ip_conf_x
        config_src = webconfig['data']['ip_conf']
        if (type(config_src) == str and len(config_src.split(',')) > 1):
            for i, value in enumerate(config_src.split(',')):
                c['obc']['ip_conf_' + str(i)] = value
        else:
            c['obc']['ip_conf_0'] = config_src

        c['obc']['ip_conf_active'] = webconfig['data']['ip_conf_active']
        c['obc']['ip_conf_time'] = webconfig['data']['ip_conf_time']
        c['obc']['required_fw'] = webconfig['data']['required_fw']
        c['obc']['ip_update'] = webconfig['data']['ip_update']
        c['obc']['ip_error_conf'] = 'https://manager.sem-app.com/obd_error.json'
        c['obc']['ip_log'] = webconfig['data']['ip_log']

        # mobile config
        c['mobile']['pin'] = webconfig['data']['sim_pin']
        c['mobile']['apn'] = webconfig['data']['sim_apn']

        # mqtt broker configuration
        c['mqtt']['user'] = 'obc'
        c['mqtt']['pw'] = 'TLS$arefulsec'
        c['mqtt']['ip_broker'] = webconfig['data']['ip_broker']
        c['mqtt']['port_broker'] = 8883
        c['mqtt']['data_interval'] = 1000
        c['mqtt']['health_interval'] = 30000

        # configuration serial number, dataversion
        c['manufacturer']['InternalSerialNo_device'] = self.bb
        c['manufacturer']['ExternalSerialNo_device'] = self.obc
        # Health service will check the remote serial number and warn if they don't match
        c['manufacturer']['InternalSerialNo_remote'] = webconfig['data']['sn_bb']
        c['manufacturer']['ExternalSerialNo_remote'] = webconfig['data']['sn_obc']
        c['manufacturer']['DataVersion'] = 5

        return c

    def get_team_no(self):
        return self.latest_conf['data']['tnr']

    def get_ini_conf(self, addrs):
        """
        gets config
        translates json into ini/dict
        returns config in ini format/dict
        return false, when config still the same or failed to get config
        """
        conf = self.__request_conf(self.bb, addrs)

        if not conf or not conf['success']:
            print('[' + str(datetime.datetime.now()) + '] fail to get conf')
            if(conf['ErrorMessage']):
                print('[' + str(datetime.datetime.now()) + '] --> ' + conf['ErrorMessage'])
            return False

        # make configs comparable, timestamp always changes
        self.latest_conf['data']['ip_conf_time'] = conf['data']['ip_conf_time']

        if not conf == self.latest_conf:
            try:
                # translate into ini capable dictionary
                ret = self.__web2ini(conf)
                self.latest_conf = conf
                return ret
            except Exception as e :
                print("conf conversion failed: " + str(e))

        return False
