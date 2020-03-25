Return-Path: virtio-dev-return-6977-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C4B8985ECA
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Mar 2020 09:47:35 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Wed, 25 Mar 2020 10:47:28 +0100
Message-ID: <6557912.4vTCxPXJkl@os-lin-dmo>
In-Reply-To: <CAD90VcZ2zzzwveYgDs5UdjfZUt=yX4wNX-f_-3V18xz93_fpvQ@mail.gmail.com>
References: <20200206102058.247258-1-keiichiw@chromium.org> <8121654.T7Z3S40VBb@os-lin-dmo> <CAD90VcZ2zzzwveYgDs5UdjfZUt=yX4wNX-f_-3V18xz93_fpvQ@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: Alexandre Courbot <acourbot@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

On Montag, 23. M=E4rz 2020 16:48:14 CET Keiichi Watanabe wrote:
> Hi,
>=20
> On Mon, Mar 23, 2020 at 10:28 PM Dmitry Sepp
>=20
> <dmitry.sepp@opensynergy.com> wrote:
> > Hi Keiichi,
> >=20
> > On Montag, 23. M=E4rz 2020 13:07:54 CET Keiichi Watanabe wrote:
> > > Hi everyone,
> > >=20
> > > I have implemented a virtio-video device following my v3 spec in
> > > crosvm, which worked well together with Dmitry's driver [1]. I've
> > > started preparing v4 proposal to address problems found while
> > > implementing the driver and the devices.
> >=20
> > Great news!
> >=20
> > > Regarding v3 protocol, I'm thinking about how we can differentiate
> > > 'parameters' and 'controls' in the virtio-video spec?
> > > In the previous discussion, we decided to have a profile, level and
> > > bitrate as controls because we want to query supported values for eac=
h
> > > field.
> > > But, I don't think it's a good criteria because it'd be possible to
> > > query other values in params.
> >=20
> > Could you elaborate on this? Do you now how the design could look like =
or
> > it is just an idea? AFAIR during the discussion of OpenSynergy's origin=
al
> > v1 spec your point was to separate something that we call 'controls' no=
w
> > to reduce the command data size and make command handling less error
> > prone.
>=20
> The problem in v3 is that if we want to add a new value to be set it'd
> be unclear which params or controls is better to be extended.
> One possible rule may be "if a value can be queried by the driver, it
> should be a control". However, this rule doesn't explain why we have
> "format" in params for example. So, I think we need a discussion and
> may want to rearrange the structures.
>=20
> Yeah, in the previous discussion, I suggested to have profile, level
> and bitrate as control values instead of members of params. Now, I'm
> wondering whether we can have every values as control values.
> I don't think it's a perfect idea, but I haven't come up with any
> better concrete design yet. So, I'd really appreciate if you could
> share your thoughts.
>=20

Ok, we can for example add more precise definition to input and output. Let=
's=20
say we have 'bitstream' format structure and a 'image' format structure. E.=
g.=20
for decoder obviously bitstream is input and image is output.

Then instead of params and controls we can define some abstract 'properties=
'.=20
And make some of the properties assigned/mapped/available to bitstream and=
=20
some to image, depending on the current function. I think that could make=
=20
sense as for example for decoder 'bitstream' probably requires very few bas=
ic=20
'properties' like fourcc format, in contrast to 'image'. But for encoder=20
'bitstream' will also have the bitrate 'property' set.

> > On one hand if don't really see any difference in params vs controls it
> > would for sure make sense to remove one of the two. On the other hand I=
'd
> > of course like to avoid moving back in forth, especially when it comes =
to
> > such a major driver rework.
>=20
> Yes, I understand that it may require a big change in the implementation.
> I'm sorry for not being able to think of this point seriously in the
> previous thread.
>=20
> Of course, I'd also really like to avoid rework, but I believe we
> shouldn't give up defining a clean and reasonable specification.
> Let's find a clear definition in this cycle to avoid future rework.
>=20
> > > So, I'm thinking about what should be the difference between params
> > > and controls. If no difference, we should deprecate
> > > virtio_video_params and have every field there as a control value
> > > instead.
> >=20
> > I deem we should then deprecate controls instead. Params seem to be mor=
e
> > abstract. Width and height don't sound like a control for me.
>=20
> Though this is actually one of options, how can we query profiles and
> levels if they are in params?
> This is why we decided them as controls.
>=20
> Best regards,
> Keiichi
>=20
> > > If we add a new command to get and set multiple controls at once, thi=
s
> > > change won't cause overhead.
> >=20
> > How would we do this? Provide a flexible array member where each entry =
has
> > a type field first?
>=20
> Yeah, something like the idea. But, I haven't designed an actual structur=
e
> yet.
> > What can also make sense is to potentially join set and get calls
> > (probably
> > provide 'get' stuff automatically within a response to 'set'). Anyway s=
et
> > and get are currently used in conjunction all the time.
>=20
> It'd make sense to return new input and output params when one of
> params is updated.
> But, if we choose this design, we need to assume one device has just
> two params; input and output.
>=20
> This is okay for video decoder and encoder, but it may become a
> problem if we want to support other types of video device that has
> only one direction. (e.g. video capture device)
> Though we have no plan for supporting this, OpenSynergy's v1 proposal
> contained this type IIRC.

Honestly speaking, the idea is not completely abandoned. The spec and the=
=20
driver has more than enough functionality to handle a simple Android EVS=20
camera use-case. But I think let's discuss this separately later.

Best regards,
Dmitry.

>=20
> Best regards,
> Keiichi
>=20
> > Best regards,
> > Dmitry.
> >=20
> > > What do you think? Is there anything I missed?
> > > If it sounds fine, I'll remove virtio_video_params from the v4 spec
> > > proposal.
> > >=20
> > > Best regards,
> > > Keiichi
> > >=20
> > > [1]: https://patchwork.linuxtv.org/patch/61717/



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

