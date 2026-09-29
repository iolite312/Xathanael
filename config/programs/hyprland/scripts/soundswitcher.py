import json
import subprocess
import sys

HEADSET = "alsa_output.usb-Logitech_G733_Gaming_Headset-00.analog-stereo"
SPEAKERS = "alsa_output.pci-0000_13_00.6.analog-stereo"


def pw_dump():
    return json.loads(subprocess.check_output(["pw-dump"]))


def default_sink_name(objects):
    for obj in objects:
        if obj.get("type") == "PipeWire:Interface:Metadata":
            for entry in obj.get("metadata", []):
                if entry.get("key") == "default.audio.sink":
                    return entry["value"]["name"]
    return None


def node_id(objects, name):
    for obj in objects:
        if obj.get("type") == "PipeWire:Interface:Node":
            if obj["info"]["props"].get("node.name") == name:
                return obj["id"]
    return None


def main():
    objects = pw_dump()
    target = SPEAKERS if default_sink_name(objects) == HEADSET else HEADSET

    target_id = node_id(objects, target)
    if target_id is None:
        sys.exit(f"Sink not found (unplugged or powered off?): {target}")

    subprocess.run(["wpctl", "set-default", str(target_id)], check=True)


main()