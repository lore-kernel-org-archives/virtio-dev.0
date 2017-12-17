Return-Path: virtio-dev-return-2845-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AEB23581815E
	for <virtio-dev@lists.oasis-open.org>; Sun, 17 Dec 2017 03:50:19 -0800 (PST)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sun, 17 Dec 2017 11:50:03 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739387B68@shsmsx102.ccr.corp.intel.com>
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<20171215184256.GA27160@bombadil.infradead.org>	<5A34F193.5040700@intel.com>
	<201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>
	<5A35FF89.8040500@intel.com>
 <201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>
In-Reply-To: <201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v19 3/7] xbitmap: add more operations
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "willy@infradead.org" <willy@infradead.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Tetsuo Handa [mailto:penguin-kernel@I-love.SAKURA.ne.jp]
> Sent: Sunday, December 17, 2017 6:22 PM
> To: Wang, Wei W <wei.w.wang@intel.com>; willy@infradead.org
> Cc: virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org; qemu-
> devel@nongnu.org; virtualization@lists.linux-foundation.org;
> kvm@vger.kernel.org; linux-mm@kvack.org; mst@redhat.com;
> mhocko@kernel.org; akpm@linux-foundation.org; mawilcox@microsoft.com;
> david@redhat.com; cornelia.huck@de.ibm.com;
> mgorman@techsingularity.net; aarcange@redhat.com;
> amit.shah@redhat.com; pbonzini@redhat.com;
> liliang.opensource@gmail.com; yang.zhang.wz@gmail.com;
> quan.xu@aliyun.com; nilal@redhat.com; riel@redhat.com
> Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
>=20
> Wei Wang wrote:
> > > But passing GFP_NOWAIT means that we can handle allocation failure.
> > > There is no need to use preload approach when we can handle allocatio=
n
> failure.
> >
> > I think the reason we need xb_preload is because radix tree insertion
> > needs the memory being preallocated already (it couldn't suffer from
> > memory failure during the process of inserting, probably because
> > handling the failure there isn't easy, Matthew may know the backstory
> > of
> > this)
>=20
> According to https://lwn.net/Articles/175432/ , I think that preloading i=
s
> needed only when failure to insert an item into a radix tree is a signifi=
cant
> problem.
> That is, when failure to insert an item into a radix tree is not a proble=
m, I
> think that we don't need to use preloading.

It also mentions that the preload attempts to allocate sufficient memory to=
 *guarantee* that the next radix tree insertion cannot fail.

If we check radix_tree_node_alloc(), the comments there says "this assumes =
that the caller has performed appropriate preallocation".

So, I think we would get a risk of triggering some issue without preload().

> >
> > So, I think we can handle the memory failure with xb_preload, which
> > stops going into the radix tree APIs, but shouldn't call radix tree
> > APIs without the related memory preallocated.
>=20
> It seems to me that virtio-ballon case has no problem without using
> preloading.

Why is that?

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

