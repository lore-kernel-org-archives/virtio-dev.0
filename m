Return-Path: virtio-dev-return-2840-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E4F3D581803F
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Dec 2017 10:26:59 -0800 (PST)
Date: Fri, 15 Dec 2017 20:26:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171215202238-mutt-send-email-mst@kernel.org>
References: <5A311C5E.7000304@intel.com>
 <201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
 <5A31F445.6070504@intel.com>
 <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
 <20171214181219.GA26124@bombadil.infradead.org>
 <201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
Subject: [virtio-dev] Re: [PATCH v19 3/7] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: willy@infradead.org, wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Dec 16, 2017 at 01:21:52AM +0900, Tetsuo Handa wrote:
> My understanding is that virtio-balloon wants to handle sparsely spreaded
> unsigned long values (which is PATCH 4/7) and wants to find all chunks of
> consecutive "1" bits efficiently. Therefore, I guess that holding the values
> in ascending order at store time is faster than sorting the values at read
> time.

Are you asking why is a bitmap used here, as opposed to a tree?  It's
not just store versus read. There's also the issue that memory can get
highly fragmented, if it is, the number of 1s is potentially very high.
A bitmap can use as little as 1 bit per value, it is hard to beat in
this respect.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

