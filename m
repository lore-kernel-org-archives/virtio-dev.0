Return-Path: virtio-comment-return-830-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Sun, 4 Aug 2019 14:26:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190804142517-mutt-send-email-mst@kernel.org>
References: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
 <4ecbc7e5-4539-d1f7-eabd-240f5ddd38c5@redhat.com>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC4157221D@shsmsx102.ccr.corp.intel.com>
 <20190803165842-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC4157423A@shsmsx102.ccr.corp.intel.com>
 <20190804034456-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC415744B1@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B92A36466FABC4D99BAF0BDB1FA8BBC415744B1@shsmsx102.ccr.corp.intel.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] [PATCH]
 Add virtio rpmb device specification
To: "Huang, Yang" <yang.huang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Aug 04, 2019 at 01:57:35PM +0000, Huang, Yang wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Sunday, August 4, 2019 15:49
> > To: Huang, Yang <yang.huang@intel.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>; virtio-dev@lists.oasis-open.org;
> > virtio-comment@lists.oasis-open.org; Zhu, Bing <bing.zhu@intel.com>; Winkler,
> > Tomas <tomas.winkler@intel.com>
> > Subject: Re: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] [PATCH] Add
> > virtio rpmb device specification
> > 
> > On Sun, Aug 04, 2019 at 02:07:49AM +0000, Huang, Yang wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: virtio-dev@lists.oasis-open.org
> > > > [mailto:virtio-dev@lists.oasis-open.org]
> > > > On Behalf Of Michael S. Tsirkin
> > > > Sent: Sunday, August 4, 2019 5:00
> > > > To: Huang, Yang <yang.huang@intel.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>;
> > > > virtio-dev@lists.oasis-open.org;
> > > > virtio-comment@lists.oasis-open.org; Zhu, Bing <bing.zhu@intel.com>;
> > > > Winkler, Tomas <tomas.winkler@intel.com>
> > > > Subject: [virtio-dev] Re: [virtio-comment] [PATCH] Add virtio rpmb
> > > > device specification
> > > >
> > > > On Tue, Jul 30, 2019 at 12:33:17AM +0000, Huang, Yang wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: virtio-comment@lists.oasis-open.org
> > > > > > [mailto:virtio-comment@lists.oasis-
> > > > > > open.org] On Behalf Of Paolo Bonzini
> > > > > > Sent: Monday, July 29, 2019 17:19
> > > > > > To: Huang, Yang <yang.huang@intel.com>;
> > > > > > virtio-dev@lists.oasis-open.org
> > > > > > Cc: virtio-comment@lists.oasis-open.org; mst@redhat.com; Zhu,
> > > > > > Bing <bing.zhu@intel.com>; Winkler, Tomas
> > > > > > <tomas.winkler@intel.com>
> > > > > > Subject: Re: [virtio-comment] [PATCH] Add virtio rpmb device
> > > > > > specification
> > > > > >
> > > > > > On 29/07/19 09:48, Huang Yang wrote:
> > > > > > >
> > > > > > > But virtualization software like Qemu doesn't provide
> > > > > > > eMMC/UFS/NVMe RPMB emulation. It blocks the OS like Trusty or
> > > > > > > OP-TEE running in a virtualization environment. For instance,
> > > > > > > Google right now uses another way to work around RPMB
> > > > > > > emulation issue when running Trusty in
> > > > > > ARM Qemu:
> > > > > > > https://android.googlesource.com/trusty/external/trusty/+/refs
> > > > > > > /hea
> > > > > > > ds/m
> > > > > > > aster/test-runner/
> > > > > > >
> > > > > > > Virtio RPMB standardization will definitely benefit OP-TEE,
> > > > > > > Google Trusty TEE, Qemu, OVMF or other modules to develop the
> > > > > > > RPMB based secure storage in virtualization.
> > > > > > >
> > > > > >
> > > > > > Is there any reason to use a new virtio-blk device, and not add
> > > > > > this functionality to virtio-blk?
> > > > > >
> > > > > > Paolo
> > > > >
> > > > > RPMB does not behave as a blk device. It doesn't have block device APIs.
> > > > > Current virtio blk features or definitions in spec are mostly
> > > > > useless or
> > > > inapplicable to virtio rpmb.
> > > > > It performs a different behaviors from the operations on a blk device.
> > > > > Key, writer counter or nonce are required to read/write on it.
> > > > > If add it to blk device, it will not only cause to a higher
> > > > > complexity, but also
> > > > cause to two different behaviors on a same device.
> > > > >
> > > >
> > > >
> > > > Well it seems that current RPMB implementations are all tied to a
> > > > storage device, like MMC or NVMe. Why is that and why doesn't the same
> > logic apply here?
> > > >
> > > > --
> > > > MST
> > > >
> > >
> > > RPMB is a mandatory hardware partition of eMMC, UFS and optional for
> > NVMe.
> > > It is standardized by JEDEC and NVMe.
> > > This partition is different from the user data partition that blk device emulates.
> > > It provides a signed access in an authenticated and replay protected
> > > manner that blk device does not perform. Only RPMB key owner can write
> > > to it while anybody can access to a user data partition.
> > 
> > Sorry if I'm being dense, so how is this different from e.g. NVMe?
> > 
> > --
> > MST
> 
> Do you refer to the difference between NVMe RPMB and eMMC RPMB?
> Or between NVMe RPMB partition and NVMe user data partition?

I refer to the fact that NVMe and eMMC are storage devices
that support an RPMB partition. Why is virtio blk different?
wouldn't it make sense for it to support an RPMB partition?


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

