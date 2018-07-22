# coding=utf-8
"""
download movie from dianyingtiantang, rename the files, remove the prefix

"""
import os


class rename(object):
    def __init__(self, *args):
        # self.path = args
        self.path = "Z:\下载"
        self.files = os.listdir(self.path)

    def loading_files(self):
        media_files = self.get_media_files()
        for item in media_files:
            if "[" in item:
                start = item.index("[")
                end = item.index("]") + 1
                # filter1 = item.lstrip(item[start:end]) only remove the str at the left side or right side, can't remove the str in the middle
                filter1 = item.split(item[start:end])
                new = "".join(filter1)
                if new.startswith("."):
                    new = new[1:]
                else:
                    new = new
                raw_name = self.path + os.sep + item
                new_name = self.path + os.sep + new
                os.rename(raw_name, new_name)

    def get_media_files(self):
        media_files = []
        file_type = ["mp4", "rmvb", "mkv"]
        for item in self.files:
            for type in file_type:
                if type in item:
                    media_files.append(item)
        return media_files


if __name__ == "__main__":
    rename().loading_files()
