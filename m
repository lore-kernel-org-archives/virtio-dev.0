Return-Path: virtio-dev-return-7199-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 007A4985E75
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 04:57:53 +0000 (UTC)
Date: Wed, 29 Apr 2020 00:57:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200429004531-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
Subject: [virtio-dev] Re: [PATCH 5/5] virtio: Add bounce DMA ops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Srivatsa Vaddagiri <vatsa@codeaurora.org>, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 29, 2020 at 10:22:32AM +0800, Lu Baolu wrote:
> On 2020/4/29 4:41, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> > > * Michael S. Tsirkin<mst@redhat.com>  [2020-04-28 12:17:57]:
> > >=20
> > > > Okay, but how is all this virtio specific?  For example, why not al=
low
> > > > separate swiotlbs for any type of device?
> > > > For example, this might make sense if a given device is from a
> > > > different, less trusted vendor.
> > > Is swiotlb commonly used for multiple devices that may be on differen=
t trust
> > > boundaries (and not behind a hardware iommu)?
> > Even a hardware iommu does not imply a 100% security from malicious
> > hardware. First lots of people use iommu=3Dpt for performance reasons.
> > Second even without pt, unmaps are often batched, and sub-page buffers
> > might be used for DMA, so we are not 100% protected at all times.
> >=20
>=20
> For untrusted devices, IOMMU is forced on even iommu=3Dpt is used;

I think you are talking about untrusted *drivers* like with VFIO.

On the other hand, I am talking about things like thunderbolt
peripherals being less trusted than on-board ones.

Or possibly even using swiotlb for specific use-cases where
speed is less of an issue.

E.g. my wifi is pretty slow anyway, and that card is exposed to
malicious actors all the time, put just that behind swiotlb
for security, and leave my graphics card with pt since
I'm trusting it with secrets anyway.


> and
> iotlb flush is in strict mode (no batched flushes); ATS is also not
> allowed. Swiotlb is used to protect sub-page buffers since IOMMU can
> only apply page granularity protection. Swiotlb is now used for devices
> from different trust zone.
>=20
> Best regards,
> baolu


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

