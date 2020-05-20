Return-Path: virtio-dev-return-7392-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 58DE9985F6A
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 May 2020 16:27:53 +0000 (UTC)
Date: Wed, 20 May 2020 12:27:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200520122421-mutt-send-email-mst@kernel.org>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo>
 <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
 <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
 <92ac2db087ccf8fae853284ecc8bdf187e292097.camel@ndufresne.ca>
 <CAPBb6MXUsMtNhxEPAdn4aTN8kNgt1eL8oLDDyNtXrD9bew_kMA@mail.gmail.com>
 <17ef7d07c50d419324a9191b216c8cc9ee95b1ae.camel@ndufresne.ca>
MIME-Version: 1.0
In-Reply-To: <17ef7d07c50d419324a9191b216c8cc9ee95b1ae.camel@ndufresne.ca>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Alexandre Courbot <acourbot@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Saket Sinha <saket.sinha89@gmail.com>, Kiran Pawar <Kiran.Pawar@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Pawel Osciak <posciak@chromium.org>, Emil Velikov <emil.velikov@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 20, 2020 at 12:21:05PM -0400, Nicolas Dufresne wrote:
> Le mercredi 20 mai 2020 =C3=A0 12:19 +0900, Alexandre Courbot a =C3=A9cri=
t :
> > On Wed, May 20, 2020 at 2:29 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > > Le mardi 19 mai 2020 =C3=A0 17:37 +0900, Keiichi Watanabe a =C3=A9cri=
t :
> > > > Hi Nicolas,
> > > >=20
> > > > On Fri, May 15, 2020 at 8:38 AM Nicolas Dufresne <
> > > > nicolas@ndufresne.ca
> > > > > wrote:
> > > > > Le lundi 11 mai 2020 =C3=A0 20:49 +0900, Keiichi Watanabe a =C3=
=A9crit :
> > > > > > Hi,
> > > > > >=20
> > > > > > Thanks Saket for your feedback. As Dmitry mentioned, we're focu=
sing on
> > > > > > video encoding and decoding, not camera. So, my reply was about=
 how to
> > > > > > implement paravirtualized video codec devices.
> > > > > >=20
> > > > > > On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <
> > > > > > dmitry.sepp@opensynergy.com
> > > > > > wrote:
> > > > > > > Hi Saket,
> > > > > > >=20
> > > > > > > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > > > > > > Hi Keiichi,
> > > > > > > >=20
> > > > > > > > I do not support the approach of  QEMU implementation forwa=
rding
> > > > > > > > requests to the host's vicodec module since  this can limit=
 the scope
> > > > > > > > of the virtio-video device only for testing,
> > > > > > >=20
> > > > > > > That was my understanding as well.
> > > > > >=20
> > > > > > Not really because the API which the vicodec provides is V4L2 s=
tateful
> > > > > > decoder interface [1], which are also used by other video drive=
rs on
> > > > > > Linux.
> > > > > > The difference between vicodec and actual device drivers is tha=
t
> > > > > > vicodec performs decoding in the kernel space without using spe=
cial
> > > > > > video devices. In other words, vicodec is a software decoder in=
 kernel
> > > > > > space which provides the same interface with actual video drive=
rs.
> > > > > > Thus, if the QEMU implementation can forward virtio-video reque=
sts to
> > > > > > vicodec, it can forward them to the actual V4L2 video decoder d=
evices
> > > > > > as well and VM gets access to a paravirtualized video device.
> > > > > >=20
> > > > > > The reason why we discussed vicodec in the previous thread was =
it'll
> > > > > > allow us to test the virtio-video driver without hardware requi=
rement.
> > > > > >=20
> > > > > > [1]
> > > > > > https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decod=
er.html
> > > > > >=20
> > > > > >=20
> > > > > > > > which instead can be used with multiple use cases such as -
> > > > > > > >=20
> > > > > > > > 1. VM gets access to paravirtualized  camera devices which =
shares the
> > > > > > > > video frames input through actual HW camera attached to Hos=
t.
> > > > > > >=20
> > > > > > > This use-case is out of the scope of virtio-video. Initially =
I had a plan to
> > > > > > > support capture-only streams like camera as well, but later t=
he decision was
> > > > > > > made upstream that camera should be implemented as separate d=
evice type. We
> > > > > > > still plan to implement a simple frame capture capability as =
a downstream
> > > > > > > patch though.
> > > > > > >=20
> > > > > > > > 2. If Host has multiple video devices (especially in ARM SO=
Cs over
> > > > > > > > MIPI interfaces or USB), different VM can be started or hot=
plugged
> > > > > > > > with selective video streams from actual HW video devices.
> > > > > > >=20
> > > > > > > We do support this in our device implementation. But spec in =
general has no
> > > > > > > requirements or instructions regarding this. And it is in fac=
t flexible
> > > > > > > enough
> > > > > > > to provide abstraction on top of several HW devices.
> > > > > > >=20
> > > > > > > > Also instead of using libraries like Gstreamer in Host user=
space, they
> > > > > > > > can also be used inside the VM userspace after getting acce=
ss to
> > > > > > > > paravirtualized HW camera devices .
> > > > > >=20
> > > > > > Regarding Gstreamer, I intended this video decoding API [2]. If=
 QEMU
> > > > > > can translate virtio-video requests to this API, we can easily =
support
> > > > > > multiple platforms.
> > > > > > I'm not sure how feasible it is though, as I have no experience=
 of
> > > > > > using this API by myself...
> > > > >=20
> > > > > Not sure which API you aim exactly, but what one need to remember=
 is that
> > > > > mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC=
 or other type
> > > > > of "stateless" CODEC is not trivial and can't be done without use=
rspace. Notably
> > > > > because we don't want to do bitstream parsing in the kernel on th=
e main CPU as
> > > > > security would otherwise be very hard to guaranty. The other driv=
er using same
> > > > > API as virtio-video do bitstream parsing on a dedicated co-proces=
sor (through
> > > > > firmware blobs though).
> > > > >=20
> > > > > Having bridges between virtio-video, qemu and some abstraction li=
brary like
> > > > > FFMPEG or GStreamer is certainly the best solution if you want to=
 virtualize any
> > > > > type of HW accelerated decoder or if you need to virtualized some=
thing
> > > > > proprietary (like NVDEC). Please shout if you need help.
> > > > >=20
> > > >=20
> > > > Yeah, I meant we should map virtio-video commands to a set of
> > > > abstracted userspace APIs to avoid having many platform-dependent c=
ode
> > > > in QEMU.
> > > > This is the same with what we implemented in crosvm, a VMM on
> > > > ChromiumOS. Crosvm's video device translates virtio-video commands
> > > > into our own video decoding APIs [1, 2] which supports VAAPI, V4L2
> > > > stateful and V4L2 stateless. Unfortunately, since our library is
> > > > highly depending on Chrome, we cannot reuse this for QEMU.
> > > >=20
> > > > So, I agree that using FFMPEG or GStreamer is a good idea. Probably=
,
> > > > APIs in my previous link weren't for this purpose.
> > > > Nicolas, do you know any good references for FFMPEG or GStreamer's
> > > > abstracted video decoding APIs? Then, I may be able to think about =
how
> > > > virtio-video protocols can be mapped to them.
> > >=20
> > > The FFMpeg API for libavcodec can be found here:
> > >=20
> > >   http://git.videolan.org/?p=3Dffmpeg.git;a=3Dblob;f=3Dlibavcodec/avc=
odec.h
> > >=20
> > > GStreamer does not really have such a low level CODEC API. So while
> > > it's possible to use it (Wine project uses it for it's parsers as an
> > > example, and Firefox use to have CODEC support wrapping GStreamer
> > > CODEC), there will not be any one-to-one mapping. GStreamer is often
> > > chosen as it's LGPL code does not carry directly any patented
> > > implementation. It instead rely on plugins, which maybe provided as
> > > third party, allowing to distribute your project while giving uses th=
e
> > > option to install potentially non-free technologies.
> > >=20
> > > But overall, I can describe GStreamer API for CODEC wrapping (pipelin=
e
> > > less) as:
> > >=20
> > >   - Push GstCaps describing the stream format
> > >   - Push bitstream buffer on sink pad
> > >   - When ready, buffers will be pushed through the push function
> > >     callback on src pad
> > >=20
> > > Of course nothing prevent adding something like the vda abstraction i=
n
> > > qemu and make this multi-backend capable.
> >=20
> > My understanding is that we don't need a particularly low-level API to
> > interact with. The host virtual device is receiving the whole encoded
> > data, and can thus easily reconstruct the original stream (minus the
> > container) and pass it to ffmpeg/gstreamer. So we can be pretty
> > high-level here.
> >=20
> > Now the choice of API will also determine whether we want to allow
> > emulation of codec devices, or whether we stay on a purely
> > para-virtual track. If we use e.g. gstreamer, then the host can
> > provide a virtual device that is backed by a purely software
> > implementation. This can be useful for testing purposes, but for
> > real-life usage the guest would be just as well using gstreamer
> > itself.
>=20
> Agreed.
>=20
> >=20
> > If we want to make sure that there is hardware on the host side, then
> > an API like libva might make more sense, but it would be more
> > complicated and may not support all hardware (I don't know if the V4L2
> > backends are usable for instance).
>=20
> To bring VAAPI into Qemu directly you'd have to introduce bitstream
> parser, DPB management and other CODEC specific bits. I cannot speak
> for the project, but that's re-inventing the wheel again with very
> little gain. Best is to open the discussion with them early.
>=20
> Note that it's relatively simple in both framework to only choose HW
> accelerated CODECs. In ffmpeg, HW accelerator codecs can only be used
> with HWContext, so your wrapper need to know specific HWContext for the
> specific accelerator. In GStreamer, since 1.16, we add a metadata that
> let the user know which decoder is hardware accelerated. (This is
> usually used to disable HW acceleration at the moment).

I don't know too much about the options here, unfortunately. But I
wonder about security implications of all these approaches.

We have this issue with other cases such as libusb where the
library we are using is not expecting hostile input so does
not validate it fully.
This is often the case for pass-through approaches.
Do all the options here expect untrusted input?


--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

