Return-Path: virtio-comment-return-834-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Huang, Yang" <yang.huang@intel.com>
Date: Mon, 5 Aug 2019 07:25:20 +0000
Message-ID: <0B92A36466FABC4D99BAF0BDB1FA8BBC4157494E@shsmsx102.ccr.corp.intel.com>
References: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
 <4ecbc7e5-4539-d1f7-eabd-240f5ddd38c5@redhat.com>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC4157221D@shsmsx102.ccr.corp.intel.com>
 <20190803165842-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC4157423A@shsmsx102.ccr.corp.intel.com>
 <20190804034456-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC415744B1@shsmsx102.ccr.corp.intel.com>
 <20190804142517-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC415745C2@shsmsx102.ccr.corp.intel.com>
 <20190805012242-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190805012242-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] [PATCH]
 Add virtio rpmb device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Monday, August 5, 2019 13:57
> To: Huang, Yang <yang.huang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; virtio-dev@lists.oasis-open.org;
> virtio-comment@lists.oasis-open.org; Zhu, Bing <bing.zhu@intel.com>; Wink=
ler,
> Tomas <tomas.winkler@intel.com>
> Subject: Re: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] [PATC=
H] Add
> virtio rpmb device specification
>=20
> On Mon, Aug 05, 2019 at 02:39:00AM +0000, Huang, Yang wrote:
> >
> > > > > > > > > On 29/07/19 09:48, Huang Yang wrote:
> > > > > > > > > >
> > > > > > > > > > But virtualization software like Qemu doesn't provide
> > > > > > > > > > eMMC/UFS/NVMe RPMB emulation. It blocks the OS like
> > > > > > > > > > Trusty or OP-TEE running in a virtualization
> > > > > > > > > > environment. For instance, Google right now uses
> > > > > > > > > > another way to work around RPMB emulation issue when
> > > > > > > > > > running Trusty in
> > > > > > > > > ARM Qemu:
> > > > > > > > > > https://android.googlesource.com/trusty/external/trust
> > > > > > > > > > y/+/
> > > > > > > > > > refs
> > > > > > > > > > /hea
> > > > > > > > > > ds/m
> > > > > > > > > > aster/test-runner/
> > > > > > > > > >
> > > > > > > > > > Virtio RPMB standardization will definitely benefit
> > > > > > > > > > OP-TEE, Google Trusty TEE, Qemu, OVMF or other modules
> > > > > > > > > > to develop the RPMB based secure storage in virtualizat=
ion.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Is there any reason to use a new virtio-blk device, and
> > > > > > > > > not add this functionality to virtio-blk?
> > > > > > > > >
> > > > > > > > > Paolo
> > > > > > > >
> > > > > > > > RPMB does not behave as a blk device. It doesn't have
> > > > > > > > block device
> > > APIs.
> > > > > > > > Current virtio blk features or definitions in spec are
> > > > > > > > mostly useless or
> > > > > > > inapplicable to virtio rpmb.
> > > > > > > > It performs a different behaviors from the operations on a =
blk
> device.
> > > > > > > > Key, writer counter or nonce are required to read/write on =
it.
> > > > > > > > If add it to blk device, it will not only cause to a
> > > > > > > > higher complexity, but also
> > > > > > > cause to two different behaviors on a same device.
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Well it seems that current RPMB implementations are all tied
> > > > > > > to a storage device, like MMC or NVMe. Why is that and why
> > > > > > > doesn't the same
> > > > > logic apply here?
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > > > >
> > > > > > RPMB is a mandatory hardware partition of eMMC, UFS and
> > > > > > optional for
> > > > > NVMe.
> > > > > > It is standardized by JEDEC and NVMe.
> > > > > > This partition is different from the user data partition that
> > > > > > blk device
> > > emulates.
> > > > > > It provides a signed access in an authenticated and replay
> > > > > > protected manner that blk device does not perform. Only RPMB
> > > > > > key owner can write to it while anybody can access to a user da=
ta
> partition.
> > > > >
> > > > > Sorry if I'm being dense, so how is this different from e.g. NVMe=
?
> > > > >
> > > > > --
> > > > > MST
> > > >
> > > > Do you refer to the difference between NVMe RPMB and eMMC RPMB?
> > > > Or between NVMe RPMB partition and NVMe user data partition?
> > >
> > > I refer to the fact that NVMe and eMMC are storage devices that
> > > support an RPMB partition. Why is virtio blk different?
> > > wouldn't it make sense for it to support an RPMB partition?
> >
> > RPMB is not a blk device for the reasons:
> > 1. It does not have blk device APIs, or is not applicable.
>=20
> That's a circular argument, isn't it?
>=20
> > 2. Moreover, it performs different behaviors.
> >     It behaves in an authenticated and anti-replay manner, e.g. RPMB ac=
cess is
> signed by the RPMB key, and requires a write counter.
> > 3. For RPMB and common disks, they are hardware soldered but functions
> independent.
> >
> > What do you think?
>=20
> The question to ask is whether guests use RPMB to protect contents of a
> storage device from tampering.  If yes then it makes sense as part of the=
 storage
> device it protects. for example mmc creates a bunch of fake block devices=
 for it
> - it seems likely userspace is used to dealing with it this way.
>=20
> Another question to answer is whether by adding a kernel driver within gu=
est
> you actually make guest userspace to work.
>=20
>=20
> --
> MST

The main usage of RPMB is to protected the data stored in RPMB space from t=
ampering.
I know there are some write protection interactions between RPMB and other =
partitions defined in eMMC 5.1 and UFS 3.0.
This is the only connection between RPMB and other storage space. But no pl=
an to add it to spec at this phase.

not sure my understanding of your 2nd question is accurate.=20
To protect the data storing in RPMB,
it's enough to make RPMB working for guest, by adding a virtio rpmb kernel =
driver.


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

