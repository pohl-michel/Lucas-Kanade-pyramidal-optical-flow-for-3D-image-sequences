# Script for creating a gif file given a jpg image sequence displaying the optical flow at different time steps
# Author: Michel Pohl
# License: 3-clause BSD License
#
# Rk: one can use gifsicle to further compress the output, e.g.
# gifsicle -O3 --resize-width 532 --interlace --threads output.gif -o compressed_output.gif

import os
from PIL import Image

# sequence 4 in the paper - cropped
img_dir = "Optical flow projection images/out"

root_folder = os.path.dirname(__file__)
output_file = os.path.join(root_folder, "output.gif")

nb_imgs = 9
display_time_per_frame_ms = 400

# Paths to the folders containing your two image sequences
img_sequence_paths = [
    os.path.join(root_folder, img_dir, f"frame_{i}.jpg") for i in range(1, nb_imgs + 1)
]
images = []

for img_path in img_sequence_paths:
    crt_img = Image.open(img_path)
    images.append(crt_img)

# Save the combined images as a GIF

images[0].save(
    output_file,
    save_all=True,
    append_images=images[1:],
    duration=display_time_per_frame_ms,
    loop=0,
)
