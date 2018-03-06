Return-Path: virtio-dev-return-3424-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F31675818F86
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Mar 2018 17:28:40 -0800 (PST)
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 6 Mar 2018 01:28:34 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B615539@SHSMSX103.ccr.corp.intel.com>
References: <1519800868-19594-1-git-send-email-changpeng.liu@intel.com>
 <20180305113353.GH7910@stefanha-x1.localdomain>
In-Reply-To: <20180305113353.GH7910@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [RFC v2] virtio-blk: add discard and write zeroes features to
 specification
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cavery@redhat.com" <cavery@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>, "Harris, James R" <james.r.harris@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Monday, March 5, 2018 7:34 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: virtio-dev@lists.oasis-open.org; cavery@redhat.com; pbonzini@redhat.c=
om;
> Wodkowski, PawelX <pawelx.wodkowski@intel.com>; Harris, James R
> <james.r.harris@intel.com>
> Subject: Re: [RFC v2] virtio-blk: add discard and write zeroes features t=
o
> specification
>=20
> On Wed, Feb 28, 2018 at 02:54:28PM +0800, Changpeng Liu wrote:
> > @@ -4211,6 +4227,17 @@ according to the native endian of the guest rath=
er
> than
> >    after reset can be either writeback or writethrough.  The actual
> >    mode can be determined by reading \field{writeback} after feature
> >    negotiation.
> > +
> > +\item If the VIRTIO_BLK_F_DISCARD feature is negotiated,
> > +    \field{max_discard_sectors} and \field{max_discard_seg} can be rea=
d
> > +    to determine the maximum discard sectors and maximum number of
> discard
> > +    segments for the block driver to use. \field{discard_sector_alignm=
ent}
> > +    can be used by OS when splitting a request based on alignment.
> > +
> > +\item if the VIRTIO_BLK_F_WRITE_ZEROES feature is negotiated,
> > +    \field{max_write_zeroes_sectors} and \field{max_write_zeroes_seg} =
can
> > +    be read to determine the maximum write zeroes sectors and maximum
> > +    number of write zeroes segments for the block driver to use.
>=20
> Does "sectors" use the same 512-byte units as the capacity field?  The
> term "sectors" is slightly ambiguous in this spec so it would be helpful
> to describe it explicitly.
>=20
> What are the units of discard_sector_alignment?
Ok, will add explicit unit description for those parameters in configuratio=
n space.
>=20
> >  The \field{sector} number indicates the offset (multiplied by 512) whe=
re
> >  the read or write is to occur. This field is unused and set to 0
> >  for scsi packet commands and for flush commands.
> >
> > +The \field{sector} number indicates the offset (multiplied by 512) whe=
re
> > +the read or write is to occur. This field is unused and set to 0 for
> > +commands other than read or write.
>=20
> This paragraph has been duplicated.
Thanks, will remove the duplicated paragraph.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

