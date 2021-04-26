import firebase_admin
from firebase_admin import storage
from firebase_admin import credentials
from firebase_admin import firestore
from os import listdir
from os.path import isfile, join
import os
from PIL import Image
import numpy as np


im = Image.open('images/2/image2-400-600.jpg')

im1 = im.resize((1, 1))

data = np.asarray(im1)
print(data)


onlyfolders = [f for f in listdir('./images')]
print(len(onlyfolders))


# Use the application default credentials
cred = credentials.Certificate(
    './flutter-test-42648-firebase-adminsdk-62hix-4fc6ed0a3e.json')
firebase_admin.initialize_app(cred, {
    'storageBucket': 'flutter-test-42648.appspot.com'
})

db = firestore.client()


doc_ref = db.collection(u'first').document()
doc_ref.set({
    u'first': u'Ada',
    u'last': u'Lovelace',
    u'born': 1815
})

bucket = storage.bucket()

count = 0
# for folders in onlyfolders:

#     blob = bucket.blob('21/lll.jpg')

#     blob.upload_from_filename('images/2/image2-400-600.jpg')

#     print(
#         "Blob downloaded to "+f"{bucket.name}"
#     )

blob = bucket.get_blob('ll.jpg')
# blob.download_to_filename('lol.png')
print("Blob: {}".format(blob.name))
print("Bucket: {}".format(blob.bucket.name))
print("Storage class: {}".format(blob.storage_class))
print("ID: {}".format(blob.id))
print("Size: {} bytes".format(blob.size))
print("Updated: {}".format(blob.updated))
print("Generation: {}".format(blob.generation))
print("Metageneration: {}".format(blob.metageneration))
print("Etag: {}".format(blob.etag))
print("Owner: {}".format(blob.owner))
print("Component count: {}".format(blob.component_count))
print("Crc32c: {}".format(blob.crc32c))
print("md5_hash: {}".format(blob.md5_hash))
print("Cache-control: {}".format(blob.cache_control))
print("Content-type: {}".format(blob.content_type))
print("Content-disposition: {}".format(blob.content_disposition))
print("Content-encoding: {}".format(blob.content_encoding))
print("Content-language: {}".format(blob.content_language))
print("Metadata: {}".format(blob.metadata))
print("Custom Time: {}".format(blob.custom_time))
print("Temporary hold: ", "enabled" if blob.temporary_hold else "disabled")
print(
    "Event based hold: ",
    "enabled" if blob.event_based_hold else "disabled",
)
if blob.retention_expiration_time:
    print(
        "retentionExpirationTime: {}".format(
            blob.retention_expiration_time
        )
    )
