Return-Path: virtio-dev-return-3047-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A83DA58191BD
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jan 2018 09:33:23 -0800 (PST)
Date: Wed, 24 Jan 2018 19:32:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180124193217-mutt-send-email-mst@kernel.org>
References: <1516762227-36346-1-git-send-email-wei.w.wang@intel.com>
 <1516762227-36346-3-git-send-email-wei.w.wang@intel.com>
 <20180124064923-mutt-send-email-mst@kernel.org>
 <5A681E03.1030007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A681E03.1030007@intel.com>
Subject: [virtio-dev] Re: [PATCH v23 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 24, 2018 at 01:47:47PM +0800, Wei Wang wrote:
> On 01/24/2018 01:01 PM, Michael S. Tsirkin wrote:
> > On Wed, Jan 24, 2018 at 10:50:27AM +0800, Wei Wang wrote:
> > This will not DTRT in all cases. It's quite possible
> > that host does not need the kick when ring is half full but
> > does need it later when ring is full.
> > You can kick at ring half full as optimization but you absolutely
> > still must kick on ring full. Something like:
> > 
> > if (vq->num_free == virtqueue_get_vring_size(vq) / 2 ||
> > 	vq->num_free <= 2)
> 
> Right. Would "if (vq->num_free < virtqueue_get_vring_size(vq) / 2" be
> better?
> 
> 
> Best,
> Wei

It gives more kicks ... this reminds me, you need to validate
that vring size is at least 2, otherwise fail probe.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

