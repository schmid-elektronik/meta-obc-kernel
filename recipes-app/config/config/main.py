import datetime

from cmdargs import CmdArgs
from conffile import ConfFile
from semapi import SemApi
from error_description import ErrorDescription
import time
import os

if __name__ == '__main__':

    options = CmdArgs()

    # get configuration source
    ini_file = ConfFile(options.getval('outfile'))

    config_src = ini_file.get_config_source()
    boot_team_no = ini_file.get_teamno()

    # get obd Json Error Description
    ErrorDescription(
        ini_file.get_error_description_source(),
        options.getval('errorfile')
    )

    api = SemApi(options.getval('sn_bb'), options.getval('sn_obc'))

    while (True):
        # request config from source
        rx_config = api.get_ini_conf(config_src)

        if(rx_config):
            ini_file.write(rx_config)
            print('[' + str(datetime.datetime.now()) + '] ' + 'new config received')

            # reboot on Teamno change
            if(not str(boot_team_no) == str(api.get_team_no())):
                print('[' + str(datetime.datetime.now()) + '] ' + 'new team number, restart OBC Agent')
                os.system('service obcagent restart')

        time.sleep(options.getval('interval'))

