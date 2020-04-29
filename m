Return-Path: virtio-dev-return-7202-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AC8F985E7F
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Apr 2020 09:52:13 +0000 (UTC)
Date: Wed, 29 Apr 2020 05:52:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200429055125-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20200429094410.GD5097@quicinc.com>
Subject: [virtio-dev] Re: [PATCH 5/5] virtio: Add bounce DMA ops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com, christoffer.dall@arm.com, virtualization@lists.linux-foundation.org, alex.bennee@linaro.org, iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com, will@kernel.org, linux-kernel@vger.kernel.org, pratikp@codeaurora.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 29, 2020 at 03:14:10PM +0530, Srivatsa Vaddagiri wrote:
> * Michael S. Tsirkin <mst@redhat.com> [2020-04-29 02:50:41]:
>=20
> > So it seems that with modern Linux, all one needs
> > to do on x86 is mark the device as untrusted.
> > It's already possible to do this with ACPI and with OF - would that be
> > sufficient for achieving what this patchset is trying to do?
>=20
> In my case, its not sufficient to just mark virtio device untrusted and t=
hus
> activate the use of swiotlb. All of the secondary VM memory, including th=
ose
> allocate by swiotlb driver, is private to it.

So why not make the bounce buffer memory shared then?

> An additional piece of memory is
> available to secondary VM which is shared between VMs and which is where =
I need
> swiotlb driver to do its work.
>=20
> --=20
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

