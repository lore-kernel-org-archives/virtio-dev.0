Return-Path: virtio-dev-return-2421-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EB865819266
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Jul 2017 05:48:08 -0700 (PDT)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 26 Jul 2017 12:47:47 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739285191@shsmsx102.ccr.corp.intel.com>
References: <20170724090042.GF25221@dhcp22.suse.cz>
 <59771010.6080108@intel.com> <20170725112513.GD26723@dhcp22.suse.cz>
 <597731E8.9040803@intel.com> <20170725124141.GF26723@dhcp22.suse.cz>
 <286AC319A985734F985F78AFA26841F739283F62@shsmsx102.ccr.corp.intel.com>
 <20170725145333.GK26723@dhcp22.suse.cz> <5977FCDF.7040606@intel.com>
 <20170726102458.GH2981@dhcp22.suse.cz> <59788097.6010402@intel.com>
 <20170726115506.GM2981@dhcp22.suse.cz>
In-Reply-To: <20170726115506.GM2981@dhcp22.suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v12 6/8] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wednesday, July 26, 2017 7:55 PM, Michal Hocko wrote:
> On Wed 26-07-17 19:44:23, Wei Wang wrote:
> [...]
> > I thought about it more. Probably we can use the callback function
> > with a little change like this:
> >
> > void walk_free_mem(void *opaque1, void (*visit)(void *opaque2,
> > unsigned long pfn,
> >            unsigned long nr_pages))
> > {
> >     ...
> >     for_each_populated_zone(zone) {
> >                    for_each_migratetype_order(order, type) {
> >                         report_unused_page_block(zone, order, type,
> > &page); // from patch 6
> >                         pfn =3D page_to_pfn(page);
> >                         visit(opaque1, pfn, 1 << order);
> >                     }
> >     }
> > }
> >
> > The above function scans all the free list and directly sends each
> > free page block to the hypervisor via the virtio_balloon callback
> > below. No need to implement a bitmap.
> >
> > In virtio-balloon, we have the callback:
> > void *virtio_balloon_report_unused_pages(void *opaque,  unsigned long
> > pfn, unsigned long nr_pages) {
> >     struct virtio_balloon *vb =3D (struct virtio_balloon *)opaque;
> >     ...put the free page block to the the ring of vb; }
> >
> >
> > What do you think?
>=20
> I do not mind conveying a context to the callback. I would still prefer
> to keep the original min_order to check semantic though. Why? Well,
> it doesn't make much sense to scan low order free blocks all the time
> because they are simply too volatile. Larger blocks tend to surivive for
> longer. So I assume you would only care about larger free blocks. This
> will also make the call cheaper.
> --

OK, I will keep min order there in the next version.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

