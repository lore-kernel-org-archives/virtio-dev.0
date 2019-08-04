Return-Path: virtio-comment-return-827-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Huang, Yang" <yang.huang@intel.com>
Date: Sun, 4 Aug 2019 02:07:49 +0000
Message-ID: <0B92A36466FABC4D99BAF0BDB1FA8BBC4157423A@shsmsx102.ccr.corp.intel.com>
References: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
 <4ecbc7e5-4539-d1f7-eabd-240f5ddd38c5@redhat.com>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC4157221D@shsmsx102.ccr.corp.intel.com>
 <20190803165842-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190803165842-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] [PATCH] Add virtio rpmb
 device specification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
.org]
> On Behalf Of Michael S. Tsirkin
> Sent: Sunday, August 4, 2019 5:00
> To: Huang, Yang <yang.huang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>; virtio-dev@lists.oasis-open.org;
> virtio-comment@lists.oasis-open.org; Zhu, Bing <bing.zhu@intel.com>; Wink=
ler,
> Tomas <tomas.winkler@intel.com>
> Subject: [virtio-dev] Re: [virtio-comment] [PATCH] Add virtio rpmb device
> specification
>=20
> On Tue, Jul 30, 2019 at 12:33:17AM +0000, Huang, Yang wrote:
> >
> >
> > > -----Original Message-----
> > > From: virtio-comment@lists.oasis-open.org
> > > [mailto:virtio-comment@lists.oasis-
> > > open.org] On Behalf Of Paolo Bonzini
> > > Sent: Monday, July 29, 2019 17:19
> > > To: Huang, Yang <yang.huang@intel.com>;
> > > virtio-dev@lists.oasis-open.org
> > > Cc: virtio-comment@lists.oasis-open.org; mst@redhat.com; Zhu, Bing
> > > <bing.zhu@intel.com>; Winkler, Tomas <tomas.winkler@intel.com>
> > > Subject: Re: [virtio-comment] [PATCH] Add virtio rpmb device
> > > specification
> > >
> > > On 29/07/19 09:48, Huang Yang wrote:
> > > >
> > > > But virtualization software like Qemu doesn't provide
> > > > eMMC/UFS/NVMe RPMB emulation. It blocks the OS like Trusty or
> > > > OP-TEE running in a virtualization environment. For instance,
> > > > Google right now uses another way to work around RPMB emulation
> > > > issue when running Trusty in
> > > ARM Qemu:
> > > > https://android.googlesource.com/trusty/external/trusty/+/refs/hea
> > > > ds/m
> > > > aster/test-runner/
> > > >
> > > > Virtio RPMB standardization will definitely benefit OP-TEE, Google
> > > > Trusty TEE, Qemu, OVMF or other modules to develop the RPMB based
> > > > secure storage in virtualization.
> > > >
> > >
> > > Is there any reason to use a new virtio-blk device, and not add this
> > > functionality to virtio-blk?
> > >
> > > Paolo
> >
> > RPMB does not behave as a blk device. It doesn't have block device APIs=
.
> > Current virtio blk features or definitions in spec are mostly useless o=
r
> inapplicable to virtio rpmb.
> > It performs a different behaviors from the operations on a blk device.
> > Key, writer counter or nonce are required to read/write on it.
> > If add it to blk device, it will not only cause to a higher complexity,=
 but also
> cause to two different behaviors on a same device.
> >
>=20
>=20
> Well it seems that current RPMB implementations are all tied to a storage=
 device,
> like MMC or NVMe. Why is that and why doesn't the same logic apply here?
>=20
> --
> MST
>=20

RPMB is a mandatory hardware partition of eMMC, UFS and optional for NVMe.
It is standardized by JEDEC and NVMe.=20
This partition is different from the user data partition that blk device em=
ulates.
It provides a signed access in an authenticated and replay protected manner=
 that
blk device does not perform. Only RPMB key owner can write to it while anyb=
ody
can access to a user data partition.


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

