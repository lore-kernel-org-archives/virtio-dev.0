Return-Path: virtio-dev-return-6952-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F7F3984319
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Mar 2020 10:37:04 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Mon, 16 Mar 2020 11:36:55 +0100
Message-ID: <2171890.ElGaqSPkdT@os-lin-dmo>
In-Reply-To: <CAAFQd5A-ZaTkx8YEdq=Q_KpbmzZ4kGxJ1ju8shXMot9WMytd=w@mail.gmail.com>
References: <20200218202753.652093-1-dmitry.sepp@opensynergy.com> <6194402.K2JlShyGXD@os-lin-dmo> <CAAFQd5A-ZaTkx8YEdq=Q_KpbmzZ4kGxJ1ju8shXMot9WMytd=w@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/1] video_video: Add the Virtio Video V4L2 driver
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Tomasz Figa <tfiga@chromium.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, virtio-dev@lists.oasis-open.org, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, dstaessens@chromium.org, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com, Nikolay Martyanov <Nikolay.Martyanov@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Tomasz,

On Freitag, 13. M=E4rz 2020 12:11:51 CET Tomasz Figa wrote:
> On Fri, Mar 13, 2020 at 11:27 AM Dmitry Sepp
>=20
> <dmitry.sepp@opensynergy.com> wrote:
> > Hi Tomasz,
> >=20
> > On Freitag, 13. M=E4rz 2020 11:05:35 CET Tomasz Figa wrote:
> > > On Thu, Mar 12, 2020 at 12:48 PM Dmitry Sepp
> > >=20
> > > <dmitry.sepp@opensynergy.com> wrote:
> > > > Hi Hans,
> > > >=20
> > > > One more thing:
> > > > > GFP_DMA? That's unusual. I'd expect GFP_DMA32. All V4L2 drivers u=
se
> > > > > that.
> > > >=20
> > > > GFP_DMA32 had no effect for me on arm64. Probably I need to recheck=
.
> > >=20
> > > What's the reason to use any specific GFP flags at all? GFP_DMA(32)
> > > memory in the guest would typically correspond to host pages without
> > > any specific location guarantee.
> >=20
> > Typically, but not always, especially for non x86. Say, some platforms
> > don't have IOMMUs for codec devices and those devices require physicall=
y
> > contig low memory. We had to find a way to handle that.
>=20
> So basically your hypervisor guarantees that the guest pages inside
> the GFP_DMA zone are contiguous and DMA-able on the host as well?
> Given the Linux-specific aspect of GFP flags and differences in the
> implementation across architectures, perhaps it would be a better idea
> to use the DMA mask instead? That wouldn't currently affect vb2_dma_sg
> allocations, but in that case the host decoder would have some IOMMU
> anyway, right?
>=20

DMA mask has no effect for vb2_dma_sg, but GFP has. Unfortunately we need t=
o=20
support both of the two: low mem phys contig and low mem sg. So DMA mask=20
cannot be an option. No, there are use-cases with obsolutely no iommus.

Best regards,
Dmitry.

> > Best regards,
> > Dmitry.
> >=20
> > > Best regards,
> > > Tomasz
> > >=20
> > > > Best regards,
> > > > Dmitry.
> > > >=20
> > > > On Donnerstag, 12. M=E4rz 2020 11:18:26 CET Hans Verkuil wrote:
> > > > > On 3/12/20 11:15 AM, Dmitry Sepp wrote:
> > > > > > Hi Hans,
> > > > > >=20
> > > > > > Thank you for your great detailed review!
> > > > > >=20
> > > > > > I won't provide inline answers as your comments totally make
> > > > > > sense.
> > > > > > There
> > > > > > is>
> > > > > >=20
> > > > > > only one thing I want to mention:
> > > > > >>> + struct video_plane_format
> > > > > >>> plane_format[VIRTIO_VIDEO_MAX_PLANES];
> > > > > >>=20
> > > > > >> Why is this virtio specific? Any reason for not using
> > > > > >> VIDEO_MAX_PLANES?
> > > > > >=20
> > > > > > I'd say this is because VIDEO_MAX_PLANES does not exist outside=
 of
> > > > > > the
> > > > > > Linux OS, so for whatever other system we need a virtio specifi=
c
> > > > > > definition.
> > > > >=20
> > > > > OK, good reason :-)
> > > > >=20
> > > > > It's probably a good thing to add a comment where
> > > > > VIRTIO_VIDEO_MAX_PLANES is defined that explains this.
> > > > >=20
> > > > > Regards,
> > > > >=20
> > > > >       Hans



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

