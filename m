Return-Path: virtio-dev-return-6794-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D39C1985E3A
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 07:24:38 +0000 (UTC)
MIME-Version: 1.0
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-3-keiichiw@chromium.org> <20200225100144.c3rmtmq7kqyskkq7@sirius.home.kraxel.org>
In-Reply-To: <20200225100144.c3rmtmq7kqyskkq7@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Thu, 27 Feb 2020 16:24:25 +0900
Message-ID: <CAD90VcaFyd2bFJUYzDF7OMsm+sWFFJuAHAqCk9hFEWnR8p+zVg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 2/2] virtio-video: Define a feature for exported
 objects from different virtio devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Tue, Feb 25, 2020 at 7:01 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +        /*
> > +         * Followed by either
> > +         * - struct virtio_video_mem_entry entries[]
> > +         *   for VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES
> > +         * - struct virtio_video_object_entry entries[]
> > +         *   for VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT
>
> Wouldn't that be a single virtio_video_object_entry?
> Or could it be one per plane?

It depends on the value of "planes_layout" in virtio_video_resource_create.
I have documented this restriction as follows:

> +If \field{planes_layout} is VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER,
> +the number of \field{virtio_video_object_entry} MUST be one. If it is
> +VIRTIO_VIDEO_PLANES_LAYOUT_PER_PLANE, the number MUST be equal to
> +\field{num_planes}.

Best regards,
Keiichi


>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

