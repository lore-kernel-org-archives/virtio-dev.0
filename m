Return-Path: virtio-dev-return-7080-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19F0A985FBD
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Apr 2020 11:59:01 +0000 (UTC)
MIME-Version: 1.0
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Thu, 16 Apr 2020 20:58:46 +0900
Message-ID: <CAD90VcYAXhRdBhLtuj9wETyTd0kT-o5s6DE31DxN6KENBuDKgQ@mail.gmail.com>
Subject: [virtio-dev] Preferred layout for request/response structs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Alexandre Courbot <acourbot@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Pawel Osciak <posciak@chromium.org>, Alex Lau <alexlau@chromium.org>, David Stevens <stevensd@chromium.org>, Enrico Granata <egranata@google.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Gerd Hoffmann <kraxel@redhat.com>, Chirantan Ekbote <chirantan@chromium.org>, =?UTF-8?Q?Matti_M=C3=B6ll?= <matti.moell@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi, I'm designing virtio-video protocol [1] and thinking about its
structs' layouts.
The virtio-video protocol adopts the request-response model like
virtio-gpu and virtio-fs. While I looked at these two protocols, I
found they used different designs of having request headers.
So, I=E2=80=99m wondering what=E2=80=99s the best way of having the request=
 / response
header for virtio-video.

On the one hand, virtio-gpu's structs for each control and response
contain the virtio_gpu_ctrl_hdr as one of fields:
struct virtio_gpu_get_edid {
  struct virtio_gpu_ctrl_hdr hdr;
  ...
};
struct virtio_gpu_resp_edid {
  struct virtio_gpu_ctrl_hdr hdr;
  ...
};

On the other hand, virtio-fs separates its header struct and request
body like the FUSE protocol:
struct fuse_in_header in;
union {
  struct fuse_read_in readin;
  ...
};

When we define a new protocol, which layout is preferred? I'd
especially like to know why virtio-gpu decided to use this design and
if the design is nice.

In the latest proposal of the virtio-video [1], we chose the same
design as virtio-gpu like:
struct virtio_video_resource_queue {
  struct virtio_video_cmd_hdr hdr;
  ...
};
struct virtio_video_resource_queue_resp {
  struct virtio_video_cmd_hdr hdr;
  ...
};
However, I thought it's a bit inconvenient that we cannot know the
actual size of a struct before its header. Actually, our device
implementation reads the header first to know the size and then reads
the whole struct including the header.
If it doesn=E2=80=99t make any sense to follow the virtio-gpu=E2=80=99s hea=
der design,
I=E2=80=99d like to separate the header and the command bodies and make the
driver send two structs per command:
struct virtio_video_cmd_hdr hdr; // contains what command follows
struct virtio_video_resource_queue {
    ...
};
struct virtio_video_resource_queue_resp {
  ...
};

Any types of comments are welcome! Thanks.

[1] https://markmail.org/message/dmw3pr4fuajvarth

Best regards,
Keiichi

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

