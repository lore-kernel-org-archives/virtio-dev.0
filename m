Return-Path: virtio-dev-return-6958-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79C4E985CE6
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Mar 2020 09:18:39 +0000 (UTC)
MIME-Version: 1.0
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com>
 <CAD90VcZ5rYHw9qqS7pvaX0TP240qcmoA5MKxKuVVn-eVVrORSA@mail.gmail.com>
 <CAD90VcbON1XTuBpuqxV6E+reY8dYq08N8G-jrAO=z-6ytcvtHQ@mail.gmail.com> <1780647.tdWV9SEqCh@os-lin-dmo>
In-Reply-To: <1780647.tdWV9SEqCh@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 17 Mar 2020 18:18:26 +0900
Message-ID: <CAD90VcbG2QJvj7L-Ek64AHb4sg3tkYJKsrDn2fVO4FLiwMYOxQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v2 1/1] video_video: Add the Virtio Video V4L2 driver
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 17, 2020 at 6:10 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> w=
rote:
>
> Hi Keiichi,
>
> On Dienstag, 17. M=C3=A4rz 2020 07:53:26 CET Keiichi Watanabe wrote:
> > > > diff --git a/include/uapi/linux/virtio_video.h
> > > > b/include/uapi/linux/virtio_video.h new file mode 100644
> > > > index 000000000000..0dd98a2237c6
> > > > --- /dev/null
> > > > +++ b/include/uapi/linux/virtio_video.h
> > > > @@ -0,0 +1,469 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > >
> > > I suspect it's not expected to use GPL licence without exceptions in =
a
> > > UAPI header file:
> > > https://www.kernel.org/doc/html/v5.4/process/license-rules.html
> > >
> > > If GPL is used here, only GPL user programs can include this header
> > > file, can't they?
> > > So, can we use BSD licence like other virtio headers (e.g. virtio_gpu=
.h)?
> > >
> > > Note that I found this program when running
> > > /scripts/headers_install.sh. Though it suggested to add "WITH
> > > Linux-syscall-note", it shouldn't be the case because this header
> > > doesn't provide syscall interface.
> > >
> > > Best regards,
> > > Keiichi
> > >
> > > > +/*
> > > > + * Virtio Video Device
> > > > + *
> > > > + * This header is BSD licensed so anyone can use the definitions
> > > > + * to implement compatible drivers/servers:
> > > > + *
> >
> > Ah, this line says this header is BSD licensed.
> > So, the SPDX-License-Identifier above should be simply wrong.
> >
>
> According to some recent upstream discussion about virtio-snd, which was =
also
> proposed by our engineers, it should be
> /* SPDX-License-Identifier: BSD-3-Clause */
>

Sounds good. Thanks for letting me know.

Best regards,
Keiichi

> Best regards,
> Dmitry.
>
> > Best regards,
> > Keiichi
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

