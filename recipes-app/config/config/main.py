import os
import subprocess
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

    # get error descrioption only once
    err_desc_success = False

    api = SemApi(options.getval('sn_bb'), options.getval('sn_obc'))

    while (True):
        # get error description once
        if( not err_desc_success):
            err_desc = ErrorDescription()  # function object in py?
            err_desc_success = err_desc.get(ini_file.get_error_description_source(), options.getval('errorfile'))

        # request config from source
        rx_config = api.get_ini_conf(config_src)

        if(rx_config):
            ini_file.write(rx_config)
            print('[' + str(datetime.datetime.now()) + '] ' + 'new config received')
            print('[' + str(datetime.datetime.now()) + '] ' + 'copy to backbone...')

            # in case of different fingerprint due bb image update
            p = subprocess.Popen(["rm", "/root/.ssh/known_hosts"])
            sts = os.waitpid(p.pid, 0)
            p = subprocess.Popen(["scp", "-o", "StrictHostKeyChecking=accept-new", options.getval('outfile'), "root@192.168.1.110:"+ options.getval('outfile')])
            sts = os.waitpid(p.pid, 0)

            # reboot on Teamno change
            if(not str(boot_team_no) == str(api.get_team_no())):
                print('[' + str(datetime.datetime.now()) + '] ' + 'new team number, restart OBC Agent')
                os.system('service obcagent restart')
                os.system('service health restart')

        time.sleep(options.getval('interval'))
