import subprocess

currentAudioSink = b'alsa_output.usb-Logitech_G733_Gaming_Headset-00.analog-stereo\n'

def checkAudioSink():
    return subprocess.check_output(['/usr/bin/pactl', 'get-default-sink']).strip()

def updateAudioSink():
    sink = checkAudioSink()
    if sink == currentAudioSink.strip():
        setSpeakerAudio()
    else:
        setHeadsetAudio()

def setHeadsetAudio():
    subprocess.Popen(['/usr/bin/pactl', 'set-default-sink', 'alsa_output.usb-Logitech_G733_Gaming_Headset-00.analog-stereo'])

def setSpeakerAudio():
    subprocess.Popen(['/usr/bin/pactl', 'set-default-sink', 'alsa_output.pci-0000_13_00.6.analog-stereo'])

updateAudioSink()