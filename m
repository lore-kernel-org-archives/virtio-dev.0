Return-Path: virtio-dev-return-7373-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83AA1985F47
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 May 2020 08:37:58 +0000 (UTC)
MIME-Version: 1.0
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90Vcb-x1KV++fWrmx+fLV5eNc2DiTtn8=OjQi7aUf7B0ULdA@mail.gmail.com>
 <CAK25hWM-hLdk=MSKgceumOUo9ZNBrrmM8qSe7MvTUAPGmur_HQ@mail.gmail.com>
 <2515515.r9knKAEANn@os-lin-dmo> <CAD90VcYeF7drbYNDiEioPBHcQcifqDYUia_CKqNLv_5VAMjPKw@mail.gmail.com>
 <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
In-Reply-To: <67e1ba850c5fbf84b09ec8266ab70dd08a10c2e3.camel@ndufresne.ca>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 19 May 2020 17:37:43 +0900
Message-ID: <CAD90VcaqE7PsLV=-xwWHXkct61wsiAuOCH78aLGSObfX9LqGsw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: Fwd: Qemu Support for Virtio Video V4L2 driver
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, Saket Sinha <saket.sinha89@gmail.com>, Kiran Pawar <Kiran.Pawar@opensynergy.com>, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Alexandre Courbot <acourbot@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Pawel Osciak <posciak@chromium.org>, Emil Velikov <emil.velikov@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Nicolas,

On Fri, May 15, 2020 at 8:38 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le lundi 11 mai 2020 =C3=A0 20:49 +0900, Keiichi Watanabe a =C3=A9crit :
> > Hi,
> >
> > Thanks Saket for your feedback. As Dmitry mentioned, we're focusing on
> > video encoding and decoding, not camera. So, my reply was about how to
> > implement paravirtualized video codec devices.
> >
> > On Mon, May 11, 2020 at 8:25 PM Dmitry Sepp <dmitry.sepp@opensynergy.co=
m>
> > wrote:
> > > Hi Saket,
> > >
> > > On Montag, 11. Mai 2020 13:05:53 CEST Saket Sinha wrote:
> > > > Hi Keiichi,
> > > >
> > > > I do not support the approach of  QEMU implementation forwarding
> > > > requests to the host's vicodec module since  this can limit the sco=
pe
> > > > of the virtio-video device only for testing,
> > >
> > > That was my understanding as well.
> >
> > Not really because the API which the vicodec provides is V4L2 stateful
> > decoder interface [1], which are also used by other video drivers on
> > Linux.
> > The difference between vicodec and actual device drivers is that
> > vicodec performs decoding in the kernel space without using special
> > video devices. In other words, vicodec is a software decoder in kernel
> > space which provides the same interface with actual video drivers.
> > Thus, if the QEMU implementation can forward virtio-video requests to
> > vicodec, it can forward them to the actual V4L2 video decoder devices
> > as well and VM gets access to a paravirtualized video device.
> >
> > The reason why we discussed vicodec in the previous thread was it'll
> > allow us to test the virtio-video driver without hardware requirement.
> >
> > [1] https://www.kernel.org/doc/html/latest/media/uapi/v4l/dev-decoder.h=
tml
> >
> > > > which instead can be used with multiple use cases such as -
> > > >
> > > > 1. VM gets access to paravirtualized  camera devices which shares t=
he
> > > > video frames input through actual HW camera attached to Host.
> > >
> > > This use-case is out of the scope of virtio-video. Initially I had a =
plan to
> > > support capture-only streams like camera as well, but later the decis=
ion was
> > > made upstream that camera should be implemented as separate device ty=
pe. We
> > > still plan to implement a simple frame capture capability as a downst=
ream
> > > patch though.
> > >
> > > > 2. If Host has multiple video devices (especially in ARM SOCs over
> > > > MIPI interfaces or USB), different VM can be started or hotplugged
> > > > with selective video streams from actual HW video devices.
> > >
> > > We do support this in our device implementation. But spec in general =
has no
> > > requirements or instructions regarding this. And it is in fact flexib=
le
> > > enough
> > > to provide abstraction on top of several HW devices.
> > >
> > > > Also instead of using libraries like Gstreamer in Host userspace, t=
hey
> > > > can also be used inside the VM userspace after getting access to
> > > > paravirtualized HW camera devices .
> >
> > Regarding Gstreamer, I intended this video decoding API [2]. If QEMU
> > can translate virtio-video requests to this API, we can easily support
> > multiple platforms.
> > I'm not sure how feasible it is though, as I have no experience of
> > using this API by myself...
>
> Not sure which API you aim exactly, but what one need to remember is that
> mapping virtio-video CODEC on top of VAAPI, V4L2 Stateless, NVDEC or othe=
r type
> of "stateless" CODEC is not trivial and can't be done without userspace. =
Notably
> because we don't want to do bitstream parsing in the kernel on the main C=
PU as
> security would otherwise be very hard to guaranty. The other driver using=
 same
> API as virtio-video do bitstream parsing on a dedicated co-processor (thr=
ough
> firmware blobs though).
>
> Having bridges between virtio-video, qemu and some abstraction library li=
ke
> FFMPEG or GStreamer is certainly the best solution if you want to virtual=
ize any
> type of HW accelerated decoder or if you need to virtualized something
> proprietary (like NVDEC). Please shout if you need help.
>

Yeah, I meant we should map virtio-video commands to a set of
abstracted userspace APIs to avoid having many platform-dependent code
in QEMU.
This is the same with what we implemented in crosvm, a VMM on
ChromiumOS. Crosvm's video device translates virtio-video commands
into our own video decoding APIs [1, 2] which supports VAAPI, V4L2
stateful and V4L2 stateless. Unfortunately, since our library is
highly depending on Chrome, we cannot reuse this for QEMU.

So, I agree that using FFMPEG or GStreamer is a good idea. Probably,
APIs in my previous link weren't for this purpose.
Nicolas, do you know any good references for FFMPEG or GStreamer's
abstracted video decoding APIs? Then, I may be able to think about how
virtio-video protocols can be mapped to them.

[1] libvda's C interface:
https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/=
arc/vm/libvda/libvda_decode.h
[2] libvda's Rust interface:
https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/=
arc/vm/libvda/rust/

Best regards,
Keiichi

> >
> > [2]
> > https://gstreamer.freedesktop.org/documentation/tutorials/playback/hard=
ware-accelerated-video-decoding.html
> >
> > Best regards,
> > Keiichi
> >
> > >
> > > Regarding the cameras, unfortunately same as above.
> > >
> > > Best regards,
> > > Dmitry.
> > >
> > > > Regards,
> > > > Saket Sinha
> > > >
> > > > On Mon, May 11, 2020 at 12:20 PM Keiichi Watanabe <keiichiw@chromiu=
m.org>
> > > wrote:
> > > > > Hi Dmitry,
> > > > >
> > > > > On Mon, May 11, 2020 at 6:40 PM Dmitry Sepp <dmitry.sepp@opensyne=
rgy.com
> > > > > >
> > > wrote:
> > > > > > Hi Saket and all,
> > > > > >
> > > > > > As we are working with automotive platforms, unfortunately we d=
on't
> > > > > > plan
> > > > > > any Qemu reference implementation so far.
> > > > > >
> > > > > > Of course we are ready to support the community if any help is =
needed.
> > > > > > Is
> > > > > > there interest in support for the FWHT format only for testing =
purpose
> > > > > > or you want a full-featured implementation on the QEMU side?
> > > > >
> > > > > I guess we don't need to implement the codec algorithm in QEMU.
> > > > > Rather, QEMU forwards virtio-video requests to the host video dev=
ice
> > > > > or a software library such as GStreamer or ffmpeg.
> > > > > So, what we need to implement in QEMU is a kind of API translatio=
n,
> > > > > which shouldn't care about actual video formats so much.
> > > > >
> > > > > Regarding the FWHT format discussed in the patch thread [1], in m=
y
> > > > > understanding, Hans suggested to have QEMU implementation forward=
ing
> > > > > requests to the host's vicodec module [2].
> > > > > Then, we'll be able to test the virtio-video driver on QEMU on Li=
nux
> > > > > even if the host Linux has no hardware video decoder.
> > > > > (Please correct me if I'm wrong.)
> > > > >
> > > > > Let me add Hans and Linux media ML in CC.
> > > > >
> > > > > [1]  https://patchwork.linuxtv.org/patch/61717/
> > > > > [2] https://lwn.net/Articles/760650/
> > > > >
> > > > > Best regards,
> > > > > Keiichi
> > > > >
> > > > > > Please note that the spec is not finalized yet and a major upda=
te is
> > > > > > now
> > > > > > discussed with upstream and the Chrome OS team, which is also
> > > > > > interested
> > > > > > and deeply involved in the process. The update mostly implies s=
ome
> > > > > > rewording and reorganization of data structures, but for sure w=
ill
> > > > > > require a driver rework.
> > > > > >
> > > > > > Best regards,
> > > > > > Dmitry.
> > > > > >
> > > > > > On Samstag, 9. Mai 2020 16:11:43 CEST Saket Sinha wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > As suggested on #qemu-devel IRC channel, I am including virti=
o-dev,
> > > > > > > Gerd and Michael to point in the right direction how to move =
forward
> > > > > > > with Qemu support for Virtio Video V4L2 driver
> > > > > > > posted in [1].
> > > > > > >
> > > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > > >
> > > > > > > Regards,
> > > > > > > Saket Sinha
> > > > > > >
> > > > > > > On Sat, May 9, 2020 at 1:09 AM Saket Sinha <saket.sinha89@gma=
il.com>
> > > wrote:
> > > > > > > > Hi ,
> > > > > > > >
> > > > > > > > This is to inquire about Qemu support for Virtio Video V4L2=
 driver
> > > > > > > > posted in [1].
> > > > > > > > I am currently not aware of any upstream effort for Qemu re=
ference
> > > > > > > > implementation and would like to discuss how to proceed wit=
h the
> > > > > > > > same.
> > > > > > > >
> > > > > > > > [1]: https://patchwork.linuxtv.org/patch/61717/
> > > > > > > >
> > > > > > > > Regards,
> > > > > > > > Saket Sinha
> > > > > >
> > > > > > ---------------------------------------------------------------=
------
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open=
.org
> > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-op=
en.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

