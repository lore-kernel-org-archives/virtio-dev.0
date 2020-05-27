Return-Path: virtio-dev-return-7418-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 545E8985FB4
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 May 2020 12:12:36 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Wed, 27 May 2020 14:12:29 +0200
Message-ID: <3754945.rEp4dnK8H5@os-lin-dmo>
In-Reply-To: <CAD90Vca6=AGq6aN8voNyQ7Lh69LeDZzCxebGQ+sv_mU+mqRGLA@mail.gmail.com>
References: <20200206102058.247258-1-keiichiw@chromium.org> <20200206102058.247258-2-keiichiw@chromium.org> <CAD90Vca6=AGq6aN8voNyQ7Lh69LeDZzCxebGQ+sv_mU+mqRGLA@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

On Montag, 18. Mai 2020 07:17:53 CEST Keiichi Watanabe wrote:
> > +struct virtio_video_stream_create {
> > +        struct virtio_video_cmd_hdr hdr;
> > +        le32 in_mem_type; /* One of VIRTIO_VIDEO_MEM_TYPE_* types */
> > +        le32 out_mem_type; /* One of VIRTIO_VIDEO_MEM_TYPE_* types */
> > +        le32 coded_format; /* One of VIRTIO_VIDEO_FORMAT_* types */
> > +        u8 padding[4];
> > +        u8 tag[64];
> > +};
> > +\end{lstlisting}
> > +\begin{description}
> > +\item[\field{in_mem_type, out_mem_type}] is a type of buffer
> > +  management for input /output buffers. The driver MUST set a value in
> > +  \field{enum virtio_video_mem_type} that the device reported a
> > +  corresponding feature bit.
> > +\begin{description}
> > +\item[\field{VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES}] Use guest pages.
> > +\end{description}
> > +\item[\field{coded_format}] is the encoded format that will be
> > +  processed.
> > +\item[\field{tag}] is the name associated with this stream. The tag
> > +  MUST be encoded in UTF-8 and NUL-terminated.
> 
> I wonder why we need this "tag" field. I have kept this field from
> Dmitry's first proposal, where this was called "char debug_name[64]".
> However, on second thought, I have no idea what is the necessity to
> have this field. Our VMM implementation in ChromeOS simply ignores
> this field.
> If OpenSynergy's implementation relies on this field, I'm curious
> about the usage. We might want to have an enum value instead of this
> field where arbitrary values can be stored.
> 

The use of this field is not so clear because it was renamed. In fact, one can 
have an idea how it is used by simply looking at the driver code: the field is 
useful to know about the guest client app that uses the context. If someone 
wants to store arbitrary values, they have 64 bytes to do so with this so-
called tag.

> > +\end{description}
> > +
> > +The driver MUST set \field{stream_id} in \field{virtio_video_cmd_hdr}
> > +to an integer that is not used before. If a used value is passed as
> > +\field{stream_id}, the device MUST reports an error with
> > +VIRTIO_VIDEO_RESP_ERR_INVALID_STREAM_ID.
> 
> I'm wondering if we can't generate stream_id in the host side so that
> we will have less error control code. In the current design, both the
> device and the driver have error checks; the device must check that a
> given ID is available and the driver must check if the device didn't
> return the INVALID_STREAM_ID error. Instead, by generating IDs in the
> device, we will be free from this type of failure. Same for
> resource_id in RESOURCE_CREATE.
> 
> I guess this design originally came from the virtio-gpu protocol.
> However, I couldn't find a benefit of adopting the same design here.
> 

Honestly I don't see too much difference: device still needs to check whether 
the id provided by the driver within some particular command is correct. If it 
is not, it will return an error. The driver needs to check (or skip checking) 
for an error either way as long as it is possible for the driver code to send 
a wrong number.

Best regards,
Dmitry.

> Any feedback is welcome.
> 
> Best regards,
> Keiichi
> 



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

