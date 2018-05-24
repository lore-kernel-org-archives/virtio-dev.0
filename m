Return-Path: virtio-dev-return-4168-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 116015818DFE
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 May 2018 08:26:58 -0700 (PDT)
Date: Thu, 24 May 2018 23:27:05 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180524152705.GA3513@debian>
References: <20180522102615.21339-1-tiwei.bie@intel.com>
 <20180523204446-mutt-send-email-mst@kernel.org>
 <20180523223204-mutt-send-email-mst@kernel.org>
 <20180524000641.GA23755@debian>
 <20180524163054-mutt-send-email-mst@kernel.org>
 <20180524151526.GB26913@debian>
 <20180524182008-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524182008-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH v3] content: support SR-IOV
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 24, 2018 at 06:20:36PM +0300, Michael S. Tsirkin wrote:
> On Thu, May 24, 2018 at 11:15:26PM +0800, Tiwei Bie wrote:
> > On Thu, May 24, 2018 at 04:44:18PM +0300, Michael S. Tsirkin wrote:
> > > On Thu, May 24, 2018 at 08:06:41AM +0800, Tiwei Bie wrote:
> > > > On Wed, May 23, 2018 at 10:34:29PM +0300, Michael S. Tsirkin wrote:
> > > > > On Wed, May 23, 2018 at 08:54:47PM +0300, Michael S. Tsirkin wrote:
> > > > > > On Tue, May 22, 2018 at 06:26:15PM +0800, Tiwei Bie wrote:
[...]
> > > 
> > > So my point is this, VFs themselves do not have
> > > this feature.
> > 
> > Yeah. I also think VFs shouldn't present this feature.
> > 
> > > 
> > > Should all of them have it? None of them?
> > > I don't see what use it is to VFs, but maybe
> > > we will come with a use down the road.
> > > 
> > > I propose we require that
> > > 1. drivers ignore this if there is
> > > no SRIOV cap, and
> > > 
> > > 2. that devices do not expose it.
> > > 
> > > This way if we come up with a use down the road, only new drivers
> > > will negotiate it.
> > 
> > I got your point now. Thanks!
> > 
> > How about:
> > 
> > If VIRTIO_F_SR_IOV has been negotiated, a driver can enable
> > virtual functions through the device's PCI SR-IOV capability
> > structure.  A driver MUST NOT negotiate VIRTIO_F_SR_IOV if
> > the device does not have a PCI SR-IOV capability structure
> > or is not a PCI device.  A driver MUST negotiate
> > VIRTIO_F_SR_IOV and complete the feature negotiation
> > (including setting the DRIVER_OK \field{status} bit) before
> > enabling virtual functions through the device's PCI SR-IOV
> > capability structure.
> 
> Sounds good.
> 
[...]
> > > 
> > > Assuming we teach drivers they should ignore it
> > > if it is there without SRIOV, then this last one I'd make MUST NOT.
> > 
> > Okay, how about
> > 
> > A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI
> > device and presents a PCI SR-IOV capability structure,
> > otherwise it MUST NOT offer VIRTIO_F_SR_IOV.
> > 
> > Best regards,
> > Tiwei Bie
> 
> Sounds good.

Thanks a lot! I'll send a new version.

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

