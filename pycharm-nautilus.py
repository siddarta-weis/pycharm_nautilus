# Place under ~/.local/share/nautilus-python/extensions/,
# ensure you have python-nautilus package, restart Nautilus, and enjoy :)

from gi import require_version

require_version('Gtk', '3.0')
require_version('Nautilus', '3.0')
from gi.repository import Nautilus, GObject
from subprocess import call

# path to application
APPLICATION = 'pycharm-professional'

# what name do you want to see in the context menu?
APPLICATION_NAME = 'Pycharm'


class PycharmExtension(GObject.GObject, Nautilus.MenuProvider):

    def launch_application(self, menu, files):
        safe_paths = ''
        args = ''

        for file in files:
            filepath = file.get_location().get_path()
            safe_paths += '"' + filepath + '" '

        call(APPLICATION + ' ' + args + safe_paths + '&', shell=True)

    def get_file_items(self, window, files):
        item = Nautilus.MenuItem(
            name='PycharmOpen',
            label='Abrir no ' + APPLICATION_NAME,
            tip='Abrir o item selecionado no ' + APPLICATION_NAME
        )
        item.connect('activate', self.launch_application, files)

        return [item]

    def get_background_items(self, window, file_):
        item = Nautilus.MenuItem(
            name='PycharmOpenBackground',
            label='Abrir no ' + APPLICATION_NAME,
            tip='Abrir pasta atual no Pycharm'
        )
        item.connect('activate', self.launch_application, [file_])

        return [item]
