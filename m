Return-Path: virtio-dev-return-6956-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 82DD9985A8C
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Mar 2020 09:10:45 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Tue, 17 Mar 2020 10:10:31 +0100
Message-ID: <1780647.tdWV9SEqCh@os-lin-dmo>
In-Reply-To: <CAD90VcbON1XTuBpuqxV6E+reY8dYq08N8G-jrAO=z-6ytcvtHQ@mail.gmail.com>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <CAD90VcZ5rYHw9qqS7pvaX0TP240qcmoA5MKxKuVVn-eVVrORSA@mail.gmail.com> <CAD90VcbON1XTuBpuqxV6E+reY8dYq08N8G-jrAO=z-6ytcvtHQ@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/1] video_video: Add the Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

On Dienstag, 17. M=E4rz 2020 07:53:26 CET Keiichi Watanabe wrote:
> > > diff --git a/include/uapi/linux/virtio_video.h
> > > b/include/uapi/linux/virtio_video.h new file mode 100644
> > > index 000000000000..0dd98a2237c6
> > > --- /dev/null
> > > +++ b/include/uapi/linux/virtio_video.h
> > > @@ -0,0 +1,469 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> >=20
> > I suspect it's not expected to use GPL licence without exceptions in a
> > UAPI header file:
> > https://www.kernel.org/doc/html/v5.4/process/license-rules.html
> >=20
> > If GPL is used here, only GPL user programs can include this header
> > file, can't they?
> > So, can we use BSD licence like other virtio headers (e.g. virtio_gpu.h=
)?
> >=20
> > Note that I found this program when running
> > /scripts/headers_install.sh. Though it suggested to add "WITH
> > Linux-syscall-note", it shouldn't be the case because this header
> > doesn't provide syscall interface.
> >=20
> > Best regards,
> > Keiichi
> >=20
> > > +/*
> > > + * Virtio Video Device
> > > + *
> > > + * This header is BSD licensed so anyone can use the definitions
> > > + * to implement compatible drivers/servers:
> > > + *
>=20
> Ah, this line says this header is BSD licensed.
> So, the SPDX-License-Identifier above should be simply wrong.
>=20

According to some recent upstream discussion about virtio-snd, which was al=
so=20
proposed by our engineers, it should be
/* SPDX-License-Identifier: BSD-3-Clause */

Best regards,
Dmitry.

> Best regards,
> Keiichi



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

