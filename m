Return-Path: virtio-dev-return-7197-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 724E6985E75
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Apr 2020 20:41:12 +0000 (UTC)
Date: Tue, 28 Apr 2020 16:41:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200428163448-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20200428174952.GA5097@quicinc.com>
Subject: [virtio-dev] Re: [PATCH 5/5] virtio: Add bounce DMA ops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: konrad.wilk@oracle.com, jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org, pratikp@codeaurora.org, christoffer.dall@arm.com, alex.bennee@linaro.org, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> * Michael S. Tsirkin <mst@redhat.com> [2020-04-28 12:17:57]:
>=20
> > Okay, but how is all this virtio specific?  For example, why not allow
> > separate swiotlbs for any type of device?
> > For example, this might make sense if a given device is from a
> > different, less trusted vendor.
>=20
> Is swiotlb commonly used for multiple devices that may be on different tr=
ust
> boundaries (and not behind a hardware iommu)?

Even a hardware iommu does not imply a 100% security from malicious
hardware. First lots of people use iommu=3Dpt for performance reasons.
Second even without pt, unmaps are often batched, and sub-page buffers
might be used for DMA, so we are not 100% protected at all times.


> If so, then yes it sounds like a
> good application of multiple swiotlb pools.
>=20
> > All this can then maybe be hidden behind the DMA API.
>=20
> Won't we still need some changes to virtio to make use of its own pool (t=
o
> bounce buffers)? Something similar to its own DMA ops proposed in this pa=
tch?

If you are doing this for all devices, you need to either find a way
to do this without chaning DMA ops, or by doing some automatic change
to all drivers.


> > > +void virtio_bounce_set_dma_ops(struct virtio_device *vdev)
> > > +{
> > > +=09if (!bounce_buf_paddr)
> > > +=09=09return;
> > > +
> > > +=09set_dma_ops(vdev->dev.parent, &virtio_dma_ops);
> >=20
> >=20
> > I don't think DMA API maintainers will be happy with new users
> > of set_dma_ops.
>=20
> Is there an alternate API that is more preffered?

all this is supposed to be part of DMA API itself. new drivers aren't
supposed to have custom DMA ops.

> --=20
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

