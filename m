Return-Path: virtio-dev-return-7135-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E42C2985D72
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Apr 2020 12:30:44 +0000 (UTC)
MIME-Version: 1.0
References: <CAD90VcYAXhRdBhLtuj9wETyTd0kT-o5s6DE31DxN6KENBuDKgQ@mail.gmail.com>
 <20200417094122.GB9261@stefanha-x1.localdomain>
In-Reply-To: <20200417094122.GB9261@stefanha-x1.localdomain>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 21 Apr 2020 21:30:30 +0900
Message-ID: <CAD90VcYJ1K7jktTJBp=m=aw83AeQ5U0Lcjo2coqE7XFFNHtWKQ@mail.gmail.com>
Subject: Re: [virtio-dev] Preferred layout for request/response structs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Pawel Osciak <posciak@chromium.org>, Alex Lau <alexlau@chromium.org>, David Stevens <stevensd@chromium.org>, Enrico Granata <egranata@google.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Gerd Hoffmann <kraxel@redhat.com>, Chirantan Ekbote <chirantan@chromium.org>, =?UTF-8?Q?Matti_M=C3=B6ll?= <matti.moell@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Stefan,

Thank you for your advice!

Your comments totally make sense. We should keep structs simple and I
should have thought the spec and implementation separately.
tl;dr: I feel comfortable with the following design after rethinking:

struct virtio_video_resource_queue {
  le32 virtio_video_cmd_type type; /* Must be an enum variant
VIRTIO_VIDEO_CMD_TYPE_RESOURCE_QUEUE */
  le32 queue_type;
  ...
};
struct virtio_video_resource_queue_resp {
  le32 virtio_video_resp_type type; /* Must be an enum variant that
represents the result of the command; Success or error type */
  ...
};

Regarding the decoding problem in a device, we should define another
set of structs when implementing the device if it is needed.
Let me reply to your comments inline and explain the reason of my thought.

On Fri, Apr 17, 2020 at 6:41 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> On Thu, Apr 16, 2020 at 08:58:46PM +0900, Keiichi Watanabe wrote:
> > Hi, I'm designing virtio-video protocol [1] and thinking about its
> > structs' layouts.
> > The virtio-video protocol adopts the request-response model like
> > virtio-gpu and virtio-fs. While I looked at these two protocols, I
> > found they used different designs of having request headers.
> > So, I=E2=80=99m wondering what=E2=80=99s the best way of having the req=
uest / response
> > header for virtio-video.
> >
> > On the one hand, virtio-gpu's structs for each control and response
> > contain the virtio_gpu_ctrl_hdr as one of fields:
> > struct virtio_gpu_get_edid {
> >   struct virtio_gpu_ctrl_hdr hdr;
> >   ...
> > };
> > struct virtio_gpu_resp_edid {
> >   struct virtio_gpu_ctrl_hdr hdr;
> >   ...
> > };
> >
> > On the other hand, virtio-fs separates its header struct and request
> > body like the FUSE protocol:
> > struct fuse_in_header in;
> > union {
> >   struct fuse_read_in readin;
> >   ...
> > };
> >
> > When we define a new protocol, which layout is preferred? I'd
> > especially like to know why virtio-gpu decided to use this design and
> > if the design is nice.
>
> Here are my personal thoughts about request/response struct design:
>
> Make the request/response is a single entity if possible because it's
> simpler.  This works for devices where the driver places a
> request/response onto the virtqueue as a single element and the device
> completes it.
>
> Devices that have rx/tx virtqueue designs work differently, and the
> response will need to have fields that can be used to correlate the
> response with the request that it is related to.
>
> If the software processing of the request/response is inherently
> separate (e.g. the device is a transport for an existing protocol that
> has separate request/response messages), then it also makes sense to
> include extra header fields in the response - even if the driver places
> a single element into the virtqueue and you don't have an rx/tx
> virtqueue design.
>
> Regarding whether to specify a single C struct with a union for all
> request types, or whether to specify separate top-level C structs like
> virtio-gpu, it depends.  If there would be a lot of duplication then I
> think the single struct with a union approach is good.  If there is a
> lot of variation then defining separate top-level structs is cleaner
> because there's not much to share.

In the latest proposal of the virtio-video protocol, duplication is not muc=
h.
Currently, the only common field among all requests is "enum
virtio_video_cmd_type", which represents the request type.
Though its header struct has the "stream_id" field, it's not always
used. So, it's good to have "enum virtio_video_cmd_type" in every
command struct instead of having either the header struct or union.

>
> > In the latest proposal of the virtio-video [1], we chose the same
> > design as virtio-gpu like:
> > struct virtio_video_resource_queue {
> >   struct virtio_video_cmd_hdr hdr;
> >   ...
> > };
> > struct virtio_video_resource_queue_resp {
> >   struct virtio_video_cmd_hdr hdr;
>
> Are these hdr fields actually used by the driver when the request is
> completed?
>
> If your request/response is a single virtqueue element then there is no
> need to duplicate hdr into the response because the driver already has
> the request.

Originally, the header was designed to represent response type (e.g.
"Success" or a type of error) as well.
However, there is no benefit to share the same header between requests
and responses.
(I forgot why I chose this design. I think I misunderstood something.)

So, the response structs should have an enum variant to represent a
result instead.

>
> Response headers are usually only necessary in rx/tx virtqueue designs
> where the driver needs to correlate a response on the rx queue with a
> request that was sent on the tx queue.
>
> >   ...
> > };
> > However, I thought it's a bit inconvenient that we cannot know the
> > actual size of a struct before its header. Actually, our device
> > implementation reads the header first to know the size and then reads
> > the whole struct including the header.
>
> In the device implementation I would read a struct virtio_video_cmd_hdr
> from the out iov list first.  Then either read the request-specific
> struct (defined separately) or use (uint8_t *)req + offsetof(struct
> virtio_video_resource_queue, field_after_hdr) to read the remainder but
> it's ugly.

Fair enough and I think we're going to do so.
Anyway, we should not make the specification complex to solve this
type of implementation problem as far as we have solutions.

>
> > If it doesn=E2=80=99t make any sense to follow the virtio-gpu=E2=80=99s=
 header design,
> > I=E2=80=99d like to separate the header and the command bodies and make=
 the
> > driver send two structs per command:
> > struct virtio_video_cmd_hdr hdr; // contains what command follows
> > struct virtio_video_resource_queue {
> >     ...
> > };
> > struct virtio_video_resource_queue_resp {
> >   ...
> > };
>
> Yes, this is cleaner for the device emulation code.  The driver doesn't
> need this separation.
>
> Remember that the struct definitions in the VIRTIO specification are
> pseudo-C and not necessarily the exact struct definitions that drivers
> and device implementations have to use.  As long as you follow the data
> layout correctly as per the spec you can arrange your structs any way
> you want.

That's a good point I didn't pay enough attention to.

Best regards,
Keiichi

>
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

