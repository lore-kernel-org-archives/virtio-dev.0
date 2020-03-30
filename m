Return-Path: virtio-dev-return-7006-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 535E79842AE
	for <virtio-dev@lists.oasis-open.org>; Mon, 30 Mar 2020 09:54:04 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Mon, 30 Mar 2020 11:53:57 +0200
Message-ID: <2025004.irdbgypaU6@os-lin-dmo>
In-Reply-To: <CAD90VcZMDt=Xx0E+1h6U-8xa9EMjmhpvSqRb_GYq8BAHhnpTLw@mail.gmail.com>
References: <20200206102058.247258-1-keiichiw@chromium.org> <6557912.4vTCxPXJkl@os-lin-dmo> <CAD90VcZMDt=Xx0E+1h6U-8xa9EMjmhpvSqRb_GYq8BAHhnpTLw@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: Alexandre Courbot <acourbot@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

On Freitag, 27. M=E4rz 2020 04:35:13 CEST Keiichi Watanabe wrote:
> Hi Dmitry,
>=20
> On Wed, Mar 25, 2020 at 6:47 PM Dmitry Sepp <dmitry.sepp@opensynergy.com>=
=20
wrote:
> > Hi Keiichi,
> >=20
> > On Montag, 23. M=E4rz 2020 16:48:14 CET Keiichi Watanabe wrote:
> > > Hi,
> > >=20
> > > On Mon, Mar 23, 2020 at 10:28 PM Dmitry Sepp
> > >=20
> > > <dmitry.sepp@opensynergy.com> wrote:
> > > > Hi Keiichi,
> > > >=20
> > > > On Montag, 23. M=E4rz 2020 13:07:54 CET Keiichi Watanabe wrote:
> > > > > Hi everyone,
> > > > >=20
> > > > > I have implemented a virtio-video device following my v3 spec in
> > > > > crosvm, which worked well together with Dmitry's driver [1]. I've
> > > > > started preparing v4 proposal to address problems found while
> > > > > implementing the driver and the devices.
> > > >=20
> > > > Great news!
> > > >=20
> > > > > Regarding v3 protocol, I'm thinking about how we can differentiat=
e
> > > > > 'parameters' and 'controls' in the virtio-video spec?
> > > > > In the previous discussion, we decided to have a profile, level a=
nd
> > > > > bitrate as controls because we want to query supported values for
> > > > > each
> > > > > field.
> > > > > But, I don't think it's a good criteria because it'd be possible =
to
> > > > > query other values in params.
> > > >=20
> > > > Could you elaborate on this? Do you now how the design could look l=
ike
> > > > or
> > > > it is just an idea? AFAIR during the discussion of OpenSynergy's
> > > > original
> > > > v1 spec your point was to separate something that we call 'controls=
'
> > > > now
> > > > to reduce the command data size and make command handling less erro=
r
> > > > prone.
> > >=20
> > > The problem in v3 is that if we want to add a new value to be set it'=
d
> > > be unclear which params or controls is better to be extended.
> > > One possible rule may be "if a value can be queried by the driver, it
> > > should be a control". However, this rule doesn't explain why we have
> > > "format" in params for example. So, I think we need a discussion and
> > > may want to rearrange the structures.
> > >=20
> > > Yeah, in the previous discussion, I suggested to have profile, level
> > > and bitrate as control values instead of members of params. Now, I'm
> > > wondering whether we can have every values as control values.
> > > I don't think it's a perfect idea, but I haven't come up with any
> > > better concrete design yet. So, I'd really appreciate if you could
> > > share your thoughts.
> >=20
> > Ok, we can for example add more precise definition to input and output.
> > Let's say we have 'bitstream' format structure and a 'image' format
> > structure. E.g. for decoder obviously bitstream is input and image is
> > output.
> >=20
> > Then instead of params and controls we can define some abstract
> > 'properties'. And make some of the properties assigned/mapped/available
> > to bitstream and some to image, depending on the current function. I
> > think that could make sense as for example for decoder 'bitstream'
> > probably requires very few basic 'properties' like fourcc format, in
> > contrast to 'image'. But for encoder 'bitstream' will also have the
> > bitrate 'property' set.
>=20
> Ah, it sounds like a good idea to have separate structs for bitstreams
> and images.
> Okay, let me sort out properties based on the idea.
>=20
> # Bitstream
> * format
> * min/max number of buffers
> * bitrate (encoder only)
Also depending on format?

> * profile (depending on format)
> * level (depending on format/profile)
>=20
> # Image
> * format
> * min/max number of buffers
> * width/height
> * crop information
> * number of planes
> * plane format
> * plane layout
* frame rate?

>=20
> Then, we have three categories here:
> (a) Mandatory properties for bitstreams for both functions
> (b) Mandatory properties for images for both functions
> (c) Optional properties for bitstream (e.g. bitrate, profile, level)
>=20
> So, how about defining structs for each (a), (b) and (c)?
>=20
> (a) and (b) can be similar to virtio_video_params in v3 spec draft:
> e.g.
> struct virtio_video_{bitstream, image}_info {
>   int format;
>   int min_buffers;
>   int max_buffers;
>   ...
> }
Yep, this could make sense. Not sure to which of the two the frame rate sho=
uld=20
belong. I'd guess to the image.

We should also thing of a way to set this. Would we have a set/
get_bistream_info() and set/get_image_info()? Plus one generic query/get/
set_properties (can use a flexible array to provide several in one step).

Or probably event better if properties would apply to the whole stream, not=
 to=20
bitstream or image in particular. WDYT?

Best regards,
Dmitry.

>=20
> (c) would be very similar to struct virtio_video_*_control in v3.
> Renaming them to 'properties' would be a nice idea as Dmitry said.
>=20
> While the designs of structs are not changed from 'params' and
> 'controls', we now have rules for differentiation at least.
> What do you think?

>=20
> Best regards,
> Keiichi
>=20
> > > > On one hand if don't really see any difference in params vs control=
s
> > > > it
> > > > would for sure make sense to remove one of the two. On the other ha=
nd
> > > > I'd
> > > > of course like to avoid moving back in forth, especially when it co=
mes
> > > > to
> > > > such a major driver rework.
> > >=20
> > > Yes, I understand that it may require a big change in the
> > > implementation.
> > > I'm sorry for not being able to think of this point seriously in the
> > > previous thread.
> > >=20
> > > Of course, I'd also really like to avoid rework, but I believe we
> > > shouldn't give up defining a clean and reasonable specification.
> > > Let's find a clear definition in this cycle to avoid future rework.
> > >=20
> > > > > So, I'm thinking about what should be the difference between para=
ms
> > > > > and controls. If no difference, we should deprecate
> > > > > virtio_video_params and have every field there as a control value
> > > > > instead.
> > > >=20
> > > > I deem we should then deprecate controls instead. Params seem to be
> > > > more
> > > > abstract. Width and height don't sound like a control for me.
> > >=20
> > > Though this is actually one of options, how can we query profiles and
> > > levels if they are in params?
> > > This is why we decided them as controls.
> > >=20
> > > Best regards,
> > > Keiichi
> > >=20
> > > > > If we add a new command to get and set multiple controls at once,
> > > > > this
> > > > > change won't cause overhead.
> > > >=20
> > > > How would we do this? Provide a flexible array member where each en=
try
> > > > has
> > > > a type field first?
> > >=20
> > > Yeah, something like the idea. But, I haven't designed an actual
> > > structure
> > > yet.
> > >=20
> > > > What can also make sense is to potentially join set and get calls
> > > > (probably
> > > > provide 'get' stuff automatically within a response to 'set'). Anyw=
ay
> > > > set
> > > > and get are currently used in conjunction all the time.
> > >=20
> > > It'd make sense to return new input and output params when one of
> > > params is updated.
> > > But, if we choose this design, we need to assume one device has just
> > > two params; input and output.
> > >=20
> > > This is okay for video decoder and encoder, but it may become a
> > > problem if we want to support other types of video device that has
> > > only one direction. (e.g. video capture device)
> > > Though we have no plan for supporting this, OpenSynergy's v1 proposal
> > > contained this type IIRC.
> >=20
> > Honestly speaking, the idea is not completely abandoned. The spec and t=
he
> > driver has more than enough functionality to handle a simple Android EV=
S
> > camera use-case. But I think let's discuss this separately later.
> >=20
> > Best regards,
> > Dmitry.
> >=20
> > > Best regards,
> > > Keiichi
> > >=20
> > > > Best regards,
> > > > Dmitry.
> > > >=20
> > > > > What do you think? Is there anything I missed?
> > > > > If it sounds fine, I'll remove virtio_video_params from the v4 sp=
ec
> > > > > proposal.
> > > > >=20
> > > > > Best regards,
> > > > > Keiichi
> > > > >=20
> > > > > [1]: https://patchwork.linuxtv.org/patch/61717/



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

