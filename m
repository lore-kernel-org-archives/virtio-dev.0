Return-Path: virtio-dev-return-2799-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FE1A5818F97
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Dec 2017 06:10:01 -0800 (PST)
Date: Mon, 11 Dec 2017 16:09:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171211160903-mutt-send-email-mst@kernel.org>
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
 <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
 <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
 <5A2E8067.4050000@huawei.com>
 <2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 11, 2017 at 02:54:25PM +0100, Halil Pasic wrote:
> * I assume one request is supposed to correspond to one descriptor chain.
> Right? If yes, could you tell me, where is this expressed in the spec.
> 
> Halil

That's always the default for all virtio devices, exceptions have to
be noted in spec.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

