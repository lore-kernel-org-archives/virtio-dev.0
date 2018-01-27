Return-Path: virtio-dev-return-3090-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4316858191D3
	for <virtio-dev@lists.oasis-open.org>; Sat, 27 Jan 2018 05:13:20 -0800 (PST)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Sat, 27 Jan 2018 13:13:05 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7393ED398@SHSMSX101.ccr.corp.intel.com>
References: <1516790562-37889-1-git-send-email-wei.w.wang@intel.com>
 <1516790562-37889-2-git-send-email-wei.w.wang@intel.com>
 <20180125152933-mutt-send-email-mst@kernel.org> <5A6AA08B.2080508@intel.com>
 <20180126155224-mutt-send-email-mst@kernel.org>
 <20180126233950-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180126233950-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v24 1/2] mm: support reporting free page blocks
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Saturday, January 27, 2018 5:44 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 26, 2018 at 05:00:09PM +0200, Michael S. Tsirkin wrote:
> > On Fri, Jan 26, 2018 at 11:29:15AM +0800, Wei Wang wrote:
> > > On 01/25/2018 09:41 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Jan 24, 2018 at 06:42:41PM +0800, Wei Wang wrote:
> > > 2) If worse, all the blocks have been split into smaller blocks and
> > > used after the caller comes back.
> > >
> > > where could we continue?
> >
> > I'm not sure. But an alternative appears to be to hold a lock and just
> > block whoever wanted to use any pages.  Yes we are sending hints
> > faster but apparently something wanted these pages, and holding the
> > lock is interfering with this something.
>=20
> I've been thinking about it. How about the following scheme:
> 1. register balloon to get a (new) callback when free list runs empty 2. =
take
> pages off the free list, add them to the balloon specific list 3. report =
to host 4.
> readd to free list at tail 5. if callback triggers, interrupt balloon rep=
orting to
> host,
>    and readd to free list at tail

So in step 2, when we walk through the free page list, take each block, and=
 add them to the balloon specific list, is this performed under the mm lock=
? If it is still under the lock, then what would be the difference compared=
 to walking through the free list, and add each block to virtqueue?=20

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

